module.exports = {
  projects: [
    "<rootDir>/contract-testing",
  ],
  coverageReporters: ["cobertura", "lcov", "html", "text", "text-summary"],
  coverageDirectory: "<rootDir>/coverage",
  coverageThreshold: {
    global: {
      statements: 96,
      branches: 91,
      functions: 100,
      lines: 96,
    },
  },
  reporters: ["jest-junit", "default"],
  testEnvironment: "node",
  preset: "ts-jest",
};
