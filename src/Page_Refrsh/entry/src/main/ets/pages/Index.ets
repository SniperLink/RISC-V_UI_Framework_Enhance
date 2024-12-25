@Entry
@Component
struct RefreshButtonComponent {
  @State randomNumbers: Array<number> = [];
  @State refreshing: boolean = false;
  @State loadingText: string = ""; // 新增状态，用于显示加载中的文本

  @Builder
  randomNumberList() {
    List() {
      ForEach(this.randomNumbers, (number: number) => {
        ListItem() {
          Text('' + number)
            .width('100%')
            .height(80)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .backgroundColor(0xFFFFFF)
            .borderWidth(1)
        }
      })
    }
  }

  @Builder
  refreshButton() {
    Button('刷新')
      .onClick(() => {
        this.refreshing = true;
        this.loadingText = "加载中..."; // 设置加载中的文本
        this.generateRandomNumbers();
      })
      .width('100%')
      .height(60)
      .backgroundColor(Color.Blue)
      .fontSize(16)
      .margin({ top: 20 })
  }

  generateRandomNumbers() {
    // 生成五个随机数
    let newNumbers: number[] = [];
    for (let i = 0; i < 5; i++) {
      newNumbers.push(Math.floor(Math.random() * 100));
    }

    // 模拟刷新过程
    setTimeout(() => {
      this.randomNumbers = newNumbers; // 更新随机数
      this.refreshing = false; // 停止刷新状态
      this.loadingText = ""; // 清除加载中的文本
    }, 1000); // 延迟1秒后更新
  }

  build() {
    Column() {
      // 显示加载中的文本（如果有）
      if (this.loadingText) {
        Text(this.loadingText)
          .width('100%')
          .height(40)
          .fontSize(16)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 10 }) // 添加底部外边距，与列表项分隔
      }

      // 显示随机数列表和刷新按钮
      this.randomNumberList()
      this.refreshButton()
    }
    .width('100%')
    .height('100%')
    .padding({ top: 20, left: 20, right: 20 })
    .backgroundColor(0xDCDCDC)
  }
}