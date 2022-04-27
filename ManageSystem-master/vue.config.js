module.exports = {
    configureWebpack: {
        resolve: {
            alias: {
                assets: '@/assets',
                common: '@/common',
                components: '@/components',
                network: '@/network',
                views: '@/views'
            }
        }
    },
    css: {
        loaderOptions: {
            less: {
              modifyVars: {
                'primary-color': '#13c2c2',
                'layout-color': '#666'
              },
              javascriptEnabled: true
            }
        }
    }
}