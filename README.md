# Rijksmuseum API Test Suite

This project contains a series of automated tests written to verify the Rijksmuseum public API. The tests are implemented using **Robot Framework**.

## Prerequisites

To run this project locally, you will need the following software installed:

1. **Python** - Version 3.7 or higher.
2. **pip** - Python package manager.
3. **Robot Framework** - Installable via pip.
4. **Requests Library** - For API testing, installable via pip.

## Project Setup

Follow the steps below to set up the project:

1. **Clone the Repository**
   ```sh
   git clone https://github.com/Omurden/rijks-api.git
   cd rijksmuseum-api-tests
   ```

2. **Install Dependencies**
   Use pip to install the required dependencies:
   ```sh
   pip install -r requirements.txt
   ```

3. **Run Tests**
   To execute the test suite, use the following command:
   ```sh
   robot --variable API_KEY:{API_KEY} RijksmuseumAPITests.robot
   ```

   This command will execute all the test cases and save the results in the `results/` directory.

4. **View Test Reports**
   After running the tests, you can view the generated `report.html` and `log.html` files in the `results/` directory for detailed test results.

## Running Tests in CI/CD

This project is set up to be integrated with GitHub Actions. Upon opening a Pull Request, the tests will be automatically run using the Robot Framework, and the results will be available in the Actions tab. Successful tests are required before a PR can be merged into the `main` branch.