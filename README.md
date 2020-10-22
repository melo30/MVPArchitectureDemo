# MVPArchitectureDemo

一个基于`协议代理方法实现数据传输`的MVP架构 和 一个基于`KVO实现数据双向绑定`的MVVM架构 的 示例Demo

  去年写公司业务代码，发现以前的一些比较复杂的业务模块用MVC架构撸出来很容易ctl代码行数就上千了，所以开始尝试新架构MVP和MVVM来优化以前的一些复杂业务！
一直没有系统的总结下架构方面的东西。
  
  这里的Demo是基于一个简单的业务需求，分别用MVP和MVVP架构各实现了一遍。
  
  `MVP的一些细节`:
  
   1.MVP相对于MVC, 它其实只做了一件事情, 即分割业务展示和业务逻辑。展示和逻辑分开后, 只要我们能保证View在收到Presenter的数据更新通知后能正常刷新页面, 那么整个业务就没有问题。

   2.因为View收到的通知其实都是来自于Presenter层的数据获取/更新操作, 所以我们只要保证Presenter层的这些操作都是正常的就可以了。即我们只用测试Presenter层的逻辑, 不必关心View层的情况。

   3.本文更新界面的方法就一个reloadDataForUI，如果到时候业务复杂、逻辑复杂，更新界面的方法有多个(弹框、菊花等等的)，可以通过多个代理方法实现。

   4.Presenter避免过于臃肿，否则重蹈Controller的覆辙，变得难以维护 (可以使用分类Category来为presenter解压，MVVM中的viewModel同样可以如此)
  
  `MVVM注意事项`:

  1.view(这里一般是指viewController)引用viewModel，但是反过来不行(即不要在viewModel中引入#import UIKit.h,任何视图本身的引用都不应该放在viewModel中，这个是基本要求，必须满足！)，不然就     跟view产生了耦合，不方便复用和测试
  
  2.viewModel引用model，但是反过来不行。
  
  3.viewController尽量不涉及业务逻辑，让viewModel去做这些事。
  
  4.viewModel只是一个中间人，接收view的事件、调用viewModel的方法、响应viewModel的变化。
  
  5.各个viewModel之间可以有依赖。
  
  6.viewModel避免过于臃肿，否则重蹈Controller的覆辙，变得难以维护 (可以使用分类Category来为viewModel解压，MVP中的presenter同样可以如此)
  
  7.MVVM 配合一个绑定机制效果最好（PS：ReactiveCocoa你值得拥有，也可以用KVO来实现，FaceBook开源的FBKVOController也不错）。
  
  `MVVM的优势`:
  
  1.低耦合：View 可以独立于Model变化和修改，一个 viewModel 可以绑定到不同的 View 上
  2.可重用性：可以把一些视图逻辑放在一个 viewModel里面，让很多 view 重用这段视图逻辑
  3.独立开发：开发人员可以专注于业务逻辑和数据的开发 viewModel，设计人员可以专注于页面设计
  4.可测试：通常界面是比较难于测试的，而 MVVM 模式可以针对 viewModel来进行测试
  
  `MVVM 的弊端`：
  
  数据绑定使得Bug 很难被调试。你看到界面异常了，有可能是你 View 的代码有 Bug，也可能是 Model 的代码有问题。数据绑定使得一个位置的 Bug 被快速传递到别的位置，要定位原始出问题的地方就变得不那么容易了。

  代码只是一个简单示例，其实不管是MVP还是MVVM架构都会随着业务需求或者个人的架构设计思路的不同而发生变化，平时多带着业务需求去写去练才能更加熟练掌握！
