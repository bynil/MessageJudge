# MessageJudge
A filter to block unwanted messages on iOS

Available on App Store: [https://itunes.apple.com/app/id1284426780](https://itunes.apple.com/app/id1284426780)

[中文](#中文介绍)

![usage](https://user-images.githubusercontent.com/3390634/27032166-0e747772-4fa6-11e7-89f5-83ecb82621c0.gif)

# Documentation
[iOS IdentityLookup Framework](https://developer.apple.com/documentation/identitylookup)

# Installation
1. Download repo and use Xcode 9.0+ to open the project.
2. If your Apple ID is not an Apple developer account, you can sign app with your personal team. Do not forget to trust your account in iPhone (Settings -> General -> Device Management -> DEVELOPER APP -> Trust xxx) after install the app first time. Notice that apps signed by a free personal team will expire and unusable in a short time(about a week), you have to rebuild and reinstall it.
3. Change bundle identifier as you like. Remember that you need to change both `MessageJudge` and `MessageJudgeExt`, switch them in project targets.
    
    For example: `me.gexiao.MessageJudge` -> `com.yourname.MessageJudge`, `me.gexiao.MessageJudge.MessageJudgeExt` -> `com.yourname.MessageJudge.MessageJudgeExt`.
4. Create a your own App Group in MessageJudge target like this:
![app group](https://user-images.githubusercontent.com/3390634/26938860-184430ae-4ca8-11e7-9e7b-a18a85d08d5c.png)   

    For example: `group.com.yourname.messagejudge`
    
    Add MessageJudgeExt in the App Group and update group name in file ViewController.h:
    `static NSString *MJExtentsionAppGroupName = @"group.com.yourname.messagejudge";`
5. Enable switch of Settings -> Messages -> Unknown & Spam -> SMS FILTERING -> MessageJudge.
6. Once you install and enable this extension successfully, you would see a split view in your Messages app and messages filtered is listed in the right view.
    ![Messages](https://user-images.githubusercontent.com/3390634/26939798-0baa3d22-4cab-11e7-8113-9e82886804c9.PNG)

# Usage
The hole rule is divided into whitelist and blacklist; each list is composed of some condition groups with "or" relation; each condition groups is a group of some conditions with "and" relation.

Whitelist has higher priority than blacklist.

Logic diagram：

![logic](https://user-images.githubusercontent.com/3390634/27030043-53131e96-4f9d-11e7-9ae6-d4faaa8d8e45.png)

Relationship diagram：
![rule](https://user-images.githubusercontent.com/3390634/27029302-484c4206-4f9a-11e7-8f81-5bf4fd896f23.png)

![condition group](https://user-images.githubusercontent.com/3390634/27030061-64afd7ca-4f9d-11e7-8b2f-9a99b77459dd.png)

# Notice
Message filter extension can't access the systemwide general pasteboard.

If the sender is in your contacts or you have responded to a sender three or more times, messages from this sender will no longer be sent to the extension.

As Apple documentation, filter extension can send the information about messages to a server associated with app when extension can't make determination by local data and logic. I think that this feature is useless for most user. This function will send your message information to developer's server and may cause privacy risk. If you are interested in the feature, you can switch branch to "server" which I demoed it.

A filter extension/containing app without network is a safer and enough choice, I think.

A message sender will be marked as spam forever by system if his one message was tagged as `Filter` by extension. That is incomprehensible. But Apple has determined that it behaves as intended. Extension will mark the hole conversation instead of a single message as spam. To remove a conversation from filtered section, you can:

* Respond three or more times to sender.
* Add sender to contact.
* Delete message conversation and new incoming messages will be sent to the extension again.

# Requirements
iOS 11.0+ and Xcode 9.0+

# License
GPL

中文介绍
==========

从 App Store 下载: [https://itunes.apple.com/app/id1284426780](https://itunes.apple.com/app/id1284426780)

# 安装
1. 下载并打开项目，需要 Xcode 9.0 或更高版本。
2. 如果你的 Apple ID 不是开发者帐号，那么你可以在 Xcode 里选择 Personal Team 来签名。第一次安装到真机后需要在 设置/通用 里找到你的帐号信息并选择信任。
3. 修改项目的 bundle identifier。务必同时修改两个 target: `MessageJudge` 和 `MessageJudgeExt`。
    
    比如: `me.gexiao.MessageJudge` -> `com.yourname.MessageJudge`, `me.gexiao.MessageJudge.MessageJudgeExt` -> `com.yourname.MessageJudge.MessageJudgeExt`。
    
    这两个的前缀需要保持一致。注意，免费帐号签名的 App 大约在一周后就会过期无法使用，你需要再次重新编译安装。
4. 创建一个你自己的 App Group, 并把两个 target 都加入到这个 Group 里去。
    比如：`group.com.yourname.messagejudge`
    同时，你还要更新 ViewController.h 里的一行代码，把你的 Group 全名填进去:
    `static NSString *MJExtentsionAppGroupName = @"group.com.yourname.messagejudge";`
5. 打开设置里的拦截开关: 设置 -> 信息 -> 未知与垃圾信息 -> 短信过滤 -> MessageJudge.
6. 如果你成功安装并开启了这个扩展，你会在短信里看到分栏视图，右边是被过滤掉的信息。

  ![Messages](https://user-images.githubusercontent.com/3390634/26939798-0baa3d22-4cab-11e7-8113-9e82886804c9.PNG)

# 使用说明
过滤规则分为白名单和黑名单两个部分，每个具体的名单由若干条件组构成，条件组是若干个单条判断逻辑的组合。

规则的条件组之间为“或者”的逻辑关系，条件组的条件之间为“并且”的逻辑关系。

白名单比黑名单有更高的优先级。

逻辑图：

![logic](https://user-images.githubusercontent.com/3390634/27030043-53131e96-4f9d-11e7-9ae6-d4faaa8d8e45.png)

关系图：
![rule](https://user-images.githubusercontent.com/3390634/27029302-484c4206-4f9a-11e7-8f81-5bf4fd896f23.png)

![condition group](https://user-images.githubusercontent.com/3390634/27030061-64afd7ca-4f9d-11e7-8b2f-9a99b77459dd.png)

# 注意事项
短信过滤扩展无法访问系统全局的剪切板，所以目前没有办法做到自动提取验证码。

如果短信发送方已经在你的联系人列表中或者你已经回复这个发送方达到三次，那么这个发送方的短信不会再被扩展进行检测和判断。

当短信过滤扩展自己无法决定是否可以标记一条信息时，它还可以向开发者的服务器请求查询，将该条短信的内容发送到服务端进行判断。我认为这个功能对于绝大多数用户来说是多余的，并且可能带来隐私问题。如果你对此有兴趣，可以切换到 "server" 分支查看示例代码和配置。一个单机版的过滤扩展应该已经足够用了。

一个发送方的一条信息被标记为骚扰后，会导致这个发送方后续的消息永远被系统直接判定为骚扰。这个问题非常影响使用效果。Apple 回复我这是 feature，屏蔽对象是整个的 conversation 而不是单条信息。如果你想让会话被移到正常列表，你可以：

* 回复这个会话至少 3 次。
* 把发送者加到联系人里。
* 删除会话，后续进来的短信会被再次发送到扩展进行判断。

更多分析：[iOS 11 短信过滤扩展简介](https://zhuanlan.zhihu.com/p/27560301)

