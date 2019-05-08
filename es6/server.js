
const express = require('express');
const app = express();// express.static 提供静态文件，就是html, css, js 文件
app.use(express.static('./'));
app.post('/phoneLocation', (req, res) => {
    setTimeout(() => {
        res.json({
            success: true,
            obj: {
                province: '广东',
                city: '深圳'
            }
        })
    }, 1000);
})

// 返回面值列表
app.post('/faceList', (req, res) => {
    setTimeout(() => {
        res.json(
            {
                success: true,
                obj: ['100元', '300元', '5000元']
            }

        )
    }, 1000);
})
app.listen(3000, () => {
    console.log('server start');
})