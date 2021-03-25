module.exports = {
  displayName: "Lint",
  runner: "jest-runner-eslint",
  testMatch: [
    "<rootDir>/contract-testing/*.ts?(x)",
  ],
};
