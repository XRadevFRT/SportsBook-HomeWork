# SportsBook-HomeWork
<img width="716" alt="298581683-1136601f-c0eb-4e32-bcda-7da238e42854" src="https://github.com/XRadevFRT/SportsBook-HomeWork/assets/25984871/68e897cc-9810-497b-a445-6579315bc771">

## Repository Overview

The SportsBook-HomeWork repository maintains a clean and comprehensive history, with no deleted branches or pull requests. The development process is well-documented, aided by detailed pull request descriptions. Two initial merges were made duo to incorrect seetings, but every commit after that went through rebase, ensuring a seamless and informative repository history.

To facilitate understanding, commit types are categorized into specific areas, such as [Networking], [Navigation], [Modules], [UI Components], [Utilities], and [Refactoring]. This classification streamlines the tracking of changes and development steps.

## How to Run the Project

The project relies solely on native code, with the exception of the [SnapshotTesting SPM](https://github.com/pointfreeco/swift-snapshot-testing). Running the project is straightforward: open it and press Play ▶️. The application interacts with a local API through the Simulator. While it can be executed on a real device, please note that it won't connect to the server in this configuration.

The project is compatible with iOS 16+, as requested.

## Project Structure

VIPER architecture is the cornerstone of this project. No Storyboards or Nibs are used. Notably, navigation is managed by a VIPER module (FlowModule), enabling comprehensive unit testing of the app's entire navigation flow. Unit tests are organized in a mirror-like file structure within the SportsBook-HomeWorkTests directory.

## Testing

The project's structure facilitates extensive unit testing coverage, encompassing nearly every file. Snapshot tests enhance this coverage, specifically validating the views. As a result, the project boasts an impressive test coverage rate exceeding 92%:


<img width="692" alt="Screenshot 2024-01-22 at 15 45 09" src="https://github.com/XRadevFRT/SportsBook-HomeWork/assets/25984871/48883c3e-a7ea-464e-8e73-45b2dd288b59">
<img width="447" alt="Screenshot 2024-01-22 at 15 49 01" src="https://github.com/XRadevFRT/SportsBook-HomeWork/assets/25984871/e451a7a9-38f7-43d0-a560-5ceb818b3cce">




To run the unit test, switch from SportsBook-HomeWork to SportsBook-HomeWorkTests

<img width="365" alt="Screenshot 2024-01-22 at 13 50 06" src="https://github.com/XRadevFRT/SportsBook-HomeWork/assets/25984871/496ef32d-7b6a-4bf8-89c4-03d472abace7">

Keep in mind that the snapshots from the snapshot tests, are made when running the tests on iPhone 15 Pro. This means that running them on a different simulator may lead to failing tests.


## Demo

|    **SportsBook app in action**    | 
| --------------------|
|![ScreenRecording2024-01-22at12 29 37-ezgif com-video-to-gif-converter-2](https://github.com/XRadevFRT/SportsBook-HomeWork/assets/25984871/c535e58f-0d8c-4efe-ae24-29b05f8471c3)|
