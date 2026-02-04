use std::io::{BufRead, BufReader};
use std::process::{Command, Stdio};

fn print_workspaces() {
    let output = Command::new("niri")
        .args(["msg", "--json", "workspaces"])
        .output()
        .expect("Failed to execute Niri command");

    if let Ok(json_string) = String::from_utf8(output.stdout) {
        let sorted_json = sort_json_by_idx(&json_string);

        println!("{}", sorted_json);
    }
}

fn sort_json_by_idx(json_string: &str) -> String {
    let mut workspaces: Vec<serde_json::Value> =
        serde_json::from_str(json_string).expect("Niri reported garbage workspaces");

    workspaces.sort_by_key(|w| {
        w["idx"]
            .as_u64()
            .expect("Missing `idx` property in from Niri workspace")
    });

    serde_json::to_string(&workspaces).expect("Unable to generate JSON from Niri output")
}

fn main() {
    print_workspaces();

    let mut child = Command::new("niri")
        .args(["msg", "--json", "event-stream"])
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to start niri event stream");

    let stdout = child.stdout.take().expect("Failed to capture stdout");
    let reader = BufReader::new(stdout);

    for line in reader.lines() {
        match line {
            Ok(content) => {
                if let Ok(json) = serde_json::from_str::<serde_json::Value>(&content) {
                    let workspaces_changed = json.get("WorkspacesChanged").is_some();
                    let workspace_activated = json.get("WorkspaceActivated").is_some();

                    if workspaces_changed || workspace_activated {
                        print_workspaces();
                    }
                }
            }

            Err(e) => eprintln!("Error reading line: {}", e),
        }
    }

    let _ = child.wait();
}
