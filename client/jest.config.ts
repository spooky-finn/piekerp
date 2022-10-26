/** @type {import('ts-jest').JestConfigWithTsJest} */
import type { Config } from '@jest/types'

const config: Config.InitialOptions = {
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/setUpTests.ts'],

  moduleNameMapper: {
    '\\.svg': '<rootDir>/__mocks__/svgrMock.tsx',

    '.+\\.(css|styl|less|sass|scss)$': '<rootDir>/node_modules/identity-obj-proxy',

    '\\.(jpg|jpeg|png|gif|eot|otf|webp|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$':
      '<rootDir>/__mocks__/fileMock.ts'
  }
}
export default config
