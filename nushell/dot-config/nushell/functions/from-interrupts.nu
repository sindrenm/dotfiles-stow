# Convert from /proc/interrupts to structured data
export def "from interrupts" [] {
  let content = $in

  let lines = $content | lines

  let cpus = $lines
    | first
    | split row ' '
    | where { not ($in | is-empty) }

  $lines
    | skip 1
    | par-each --keep-order { |line|
        let parts = $line | split column --number 2 ':' irq rest

        let irq = $parts
          | get irq
          | str trim
          | first

        let rest = $parts
          | get rest
          | str trim
          | first

        let fields = $rest
          | split row ' '
          | where { not ($in | is-empty) }

        let counts = $fields
          | each { try { $in | into int } catch { -1 } }
          | take while { $in >= 0 }

        let description = $fields
          | skip ($counts | length)
          | str join ' '

        let cpus_and_counts = [ $cpus $counts ]
        let record = $cpus_and_counts.1
          | enumerate
          | each { |it|
            {
              column: ($cpus_and_counts.0 | get $it.index),
              value: $it.item,
            }
          }
          | transpose --header-row --as-record

        { irq: $irq }
          | merge $record
          | upsert description $description
    }
}
