
@Entry
@Component
struct ListRefreshLoad {
  @State arr: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  @State refreshing: boolean = false;
  @State isLoading: boolean = false;
  @State canLoad: boolean = false;
  @State refreshInProgress: boolean = false; // 用于防止多次触发

  @Builder
  refreshBuilder() {
    Stack({ alignContent: Alignment.Bottom }) {
      if (this.refreshing) {
        Progress({ value: 0, total: 64, type: ProgressType.Ring })
          .width(32).height(32)
          .style({ status: ProgressStatus.LOADING })
          .margin(10)
      }
    }
    .clip(true)
    .height("100%")
    .width("100%")
  }

  @Builder
  footer() {
    Row() {
      LoadingProgress().height(32).width(48)
      Text("加载中")
    }
    .width("100%")
    .height(64)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Refresh({ refreshing: $$this.refreshing, builder: this.refreshBuilder() }) {
      List() {
        ForEach(this.arr, (item: number) => {
          ListItem() {
            Text('' + item)
              .width('100%')
              .height(80)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .backgroundColor(0xFFFFFF)
          }.borderWidth(1)
        }, (item: string) => item)


        if (this.isLoading) {
          ListItem() {
            this.footer();
          }
        }
      }
      .onScrollIndex((start: number, end: number) => {
        // 上拉刷新：到达列表底部时触发
        if (end >= this.arr.length - 1 && !this.isLoading && !this.refreshInProgress) {
          this.refreshInProgress = true; // 标记刷新开始
          this.isLoading = true;
          setTimeout(() => {
            // 使用 100 以内的随机数替换数组内容
            this.arr = this.arr.map(() => Math.floor(Math.random() * 100));
            this.isLoading = false;  // 刷新完成，重置 isLoading
            this.canLoad = false;    // 结束刷新后重置 canLoad，确保下次能够再次触发刷新
            this.refreshInProgress = false;  // 允许下一次刷新
          }, 2000); // 模拟延时加载
        }
      })
      .onScrollFrameBegin((offset: number, state: ScrollState) => {
        // 仅在向上滑动时允许触发加载
        if (offset > 5 && !this.isLoading && !this.canLoad && !this.refreshInProgress) {
          this.canLoad = true; // 满足条件时，允许上拉触发刷新
        }
        return { offsetRemain: offset };
      })
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true }) // 保证回弹效果
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .onStateChange((state: RefreshStatus) => {
      // 处理下拉刷新状态
      if (state === RefreshStatus.Done) {
        this.refreshing = false;
      }
    })
    .onRefreshing(() => {
      // 模拟下拉刷新
      setTimeout(() => {
        this.arr = this.arr.map(() => Math.floor(Math.random() * 100));
        this.refreshing = false; // 刷新完成
      }, 2000); // 设置延时 2 秒
    })
  }
}


