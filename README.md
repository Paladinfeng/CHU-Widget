# CHU-Widget
中国联通流量查询 Widget

## Preview
<div  align="center">    
  <img src="https://github.com/Paladinfeng/CHU-Widget/blob/master/Example.jpg" width = "612" height = "237" alt="图片名称" align=center />
</div>

## How to use

1. Clone Project
2. Pod update
3. Replace `phoneNumber` and `stoken` in `TodayViewController`

## How to get stoken

- 启动抓包程序
- 使用微信小程序「中国联通营业厅」登录一次
- 获取 `https://alipay.10010.com/mobileWeChatApplet/radomLogin.htm` 返回值中的 stoken
