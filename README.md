# Calibre+

A [KOReader](https://github.com/koreader/koreader) plugin that browses a calibre library directly from its `metadata.db` and opens books in the reader.

This complements the built-in `calibre.koplugin` (wireless transfer / device metadata search). Instead of syncing over the network, Calibre+ points at a calibre library folder on disk — the one holding `metadata.db` — and lists the full catalog. Selecting a book resolves its file and opens it immediately.

## Features

- Browse the entire calibre library without any sync step
- Filter by title, author, or tag (`tag:fiction`, `tag:mystery alpha`)
- Sort by title, date added, or published date
- Hold a book row to see full metadata and tap tags to filter by them
- Preferred format setting (ask / EPUB / PDF) to skip the format picker
- Fast path entry (type a folder path directly) for slow e-ink folder pickers
- Database cached to fast internal storage so SD-card libraries open quickly
- Dispatcher action (`Browse calibre library`) assignable to a gesture or Quick Menu

## Requirements

- KOReader 2023.10 or later (uses `ui/plugin/insert_menu`)
- A calibre library with `metadata.db` accessible on the device filesystem

## Installation

1. Download or clone this repository.
2. Copy (or symlink) the repository folder into KOReader's `plugins/` directory and name it `calibreplus.koplugin`:

   ```
   cp -r calibreplus.koplugin /path/to/koreader/plugins/calibreplus.koplugin
   ```

3. Restart KOReader.

The plugin appears under **Tools → More tools → Calibre+**.

## Usage

1. Open **Tools → More tools → Calibre+**.
2. Tap **Set library folder** (or **Enter folder path** to type the path directly).
3. Select the root of your calibre library — the folder that contains `metadata.db`.
4. Tap **Browse library** to open the catalog.

From the catalog:
- **Tap** a book to open it.
- **Hold** a book to see metadata and tap tags to filter.
- **Tap the search icon** (top-left) to filter, sort, or reload the library.

## Quick access via gesture

The plugin registers a `Browse calibre library` dispatcher action. To assign it to a corner tap:

**Settings → Gestures → [any tap zone] → General → Browse calibre library**

## Development

Tests require a built KOReader emulator. See the [KOReader build docs](https://github.com/koreader/koreader/blob/master/doc/Building.md) for first-time setup.

```bash
# Clone upstream KOReader
git clone https://github.com/koreader/koreader.git ~/github/koreader/koreader
cd ~/github/koreader/koreader
./kodev fetch-thirdparty
./kodev build          # builds the emulator; takes ~30 min on first run

# Back in this repo
make test              # symlinks plugin + spec into KOReader and runs busted
make install           # symlink only (no test run)
make uninstall         # remove symlinks
```

Override `KOREADER_DIR` to point at a different KOReader tree:

```bash
make test KOREADER_DIR=~/github/lamida/koreader
```

## License

AGPL-3.0, same as KOReader.
