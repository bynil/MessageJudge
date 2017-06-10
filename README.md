# MessageJudge
A filter to block unwanted messages on iOS

# Documentation
[iOS IdentityLookup Framework](https://developer.apple.com/documentation/identitylookup)

# Installation
1. Download repo and use Xcode 9.0+ to open the project.
2. If your Apple ID is not a apple developer account, you can sign app with your personal team. Do not forget to trust your account in iPhone (Settings -> General -> Device Management -> DEVELOPER APP -> Trust xxx) after install the app first time. Notice that apps signed by free personal team  will expired and unusable in a short time(about a week), you have to rebuild and reinstall it.
3. Change bundle identifier as you like. Remember that you need to change both `MessageJudge` and `MessageJudgeExt`, switch them in project targets.
    
    For example: `me.gexiao.MessageJudge` -> `com.yourname.MessageJudge`, `me.gexiao.MessageJudge.MessageJudgeExt` -> `com.yourname.MessageJudge.MessageJudgeExt`.
4. Create a your own App Group in MessageJudge target like this:
![app group](https://user-images.githubusercontent.com/3390634/26938860-184430ae-4ca8-11e7-9e7b-a18a85d08d5c.png)   

    For example: `group.com.yourname.messagejudge`
    
    Add MessageJudgeExt in the App Group and update group name in file ViewController.h:
    `static NSString *MJExtentsionAppGroupName = @"group.com.yourname.messagejudge";`
5. Enable switch of Settings -> Messages -> Unknown & Spam -> SMS FILTERING -> MessageJudge.
6. Once you install and enable this extension successfully, you would see a split view in your Messages app and messages filtered is listed in right view.
    ![Messages](https://user-images.githubusercontent.com/3390634/26939798-0baa3d22-4cab-11e7-8113-9e82886804c9.PNG)


# Known issues
* A message sender may be blocked forever by system if his some messages were tagged as `Filter` by extension. It's incomprehensible and I don't know this is a bug or feature.
* If a message is filtered by extension, it will don't call sound and vibration, but the unread number is still added to Messages app.
* Extension can write down all information about messages from unknown sender and share the info with containing app, but this is forbidden in Apple's documentation for privacy reasons.

# Notice
I can't release this app on App Store because iOS 11 and Xcode 9 is still in beta. So this repository is for fun and learning. Any API or documentation about the filter extension may be changed or breaked before beta testing over.

Message filter extension can't access the systemwide general pasteboard.

If the sender is in your contacts or you have responded to a sender three times, messages from that sender will no longer be send to extension.

As Apple documentation, filter extension can send the information about messages to a server associated with app when extension can't make determination by local data and logic. I have not tested this feature because I think it's useless for most user. This function will send your message information to developer's server and may cause privacy risk.

A filter extension/containing app without network is a safer and enough choice, I think.

# Requirements
iOS 11.0+ and Xcode 9.0+

# License
GPL

中文介绍
==========

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

# 已知问题
* 一个发送方的一条信息被标记为骚扰后，可能会导致这个发送方后续的消息永远被系统直接判定为骚扰。目前无法确定这是 feature 还是 bug，想不太明白。
* 一条骚扰短信被拦截后，手机不会有提示音和震动，但这个未读数仍然会被加到短信图标上。
* 根据 Apple 的文档，出于隐私考虑扩展无法向它的容器应用(containing app)回写数据，但实际测试可以把短信的数据共享出去。

# 注意事项
在 iOS 11 和 Xcode 9 正式版本发布之前，无法发布和 Message Filter Extension 相关的 App 到 App Store，同时相关的 API 和文档可能会有更新。所以这个项目是出于个人学习的目的，希望能有方法降低生活中骚扰短信带来的干扰。

短信过滤扩展无法访问到系统全局的剪切板。

如果短信发送方已经在你的联系人列表中或者你已经回复这个发送方达到三次，那么这个发送方的短信不会再被扩展进行检测和判断。

当短信过滤扩展自己无法决定是否可以标记一条信息时，它还可以向开发者的服务器请求查询，将该条短信的内容发送到服务端进行判断。我目前还没有写这个功能的相关代码也没有做过任何测试，因为我认为这个功能对于绝大多数用户来说是多余的，并且可能带来隐私问题。一个单机版的过滤扩展应该已经足够用了。


