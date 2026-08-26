{
  standardNull: {
    mode: 'absolute',
    steps: [
      { color: 'green', value: null },
      { color: 'red', value: 80 },
    ],
  },
  standardZero: {
    mode: 'absolute',
    steps: [
      { color: 'green', value: 0 },
      { color: 'red', value: 80 },
    ],
  },
  utilization: {
    mode: 'absolute',
    steps: [
      { color: 'green', value: 0 },
      { color: 'yellow', value: 70 },
      { color: 'orange', value: 85 },
      { color: 'red', value: 95 },
    ],
  },
  greenOnly: {
    mode: 'absolute',
    steps: [{ color: 'green', value: 0 }],
  },
  legacyNoValue: {
    mode: 'absolute',
    steps: [
      { color: 'green' },
      { color: 'red', value: 80 },
    ],
  },
  inverseRisk: {
    mode: 'absolute',
    steps: [
      { color: 'red', value: 0 },
      { color: 'yellow', value: 10 },
      { color: 'green', value: 20 },
    ],
  },
  warning80Critical90: {
    mode: 'absolute',
    steps: [
      { color: 'green', value: null },
      { color: 'orange', value: 80 },
      { color: 'red', value: 90 },
    ],
  },
}
