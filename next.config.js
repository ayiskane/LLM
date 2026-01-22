/** @type {import('next').NextConfig} */

const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true',
});

const nextConfig = {
  reactStrictMode: true,
  // Enable static exports for PWA
  output: process.env.NODE_ENV === 'production' ? 'standalone' : undefined,
};

module.exports = withBundleAnalyzer(nextConfig);
