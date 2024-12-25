// xxx.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct RefreshExample {
  @State isRefreshing: boolean = false
  @State arr: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
  @State message: string = 'Hello World!!';

  aboutToAppear(): void {
    this.arr = this.arr.map(() => (Math.random() * 100).toFixed(0))
    // this.arr = get_data()
  }

  build() {
    Column() {

      Refresh({ refreshing: $$this.isRefreshing }) {
        List() {
          ForEach(this.arr, (item: string) => {
            ListItem() {
              Text('' + item)
                .width('70%')
                .height(100)
                .fontSize(16)
                .margin(10)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0xFFFFFF)
            }
          }, (item: string) => item)
        }
        .onScrollIndex((first: number) => {
          console.info(first.toString())
        })
        .width('100%')
        .height('90%')
        .alignListItem(ListItemAlign.Center)
        .scrollBar(BarState.Off)
      }
      .onStateChange((refreshStatus: RefreshStatus) => {
        console.info('Refresh onStatueChange state is ' + refreshStatus)
      })
      .onRefreshing(() => {
        setTimeout(() => {
          this.arr = this.arr.map(() => (Math.random() * 100).toFixed(0))
          this.isRefreshing = false
        }, 2000)
        console.log('onRefreshing test')
      })
      .backgroundColor(0x89CFF0)

      // Text(this.message)
      //   .fontSize(25)
      //   .fontWeight(FontWeight.Bold)
      Button('router to pageOne', { stateEffect: true, type: ButtonType.Capsule })
        .width('80%')
        .height(40)
        .margin(20)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/Index' // 目标url
          }, router.RouterMode.Standard, (err) => {
            if (err) {
              console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
              return;
            }
            console.info('Invoke pushUrl succeeded.');
            // 按钮刷新
            // this.arr = this.arr.map(() => (Math.random() * 100).toFixed(0))
          })
        })
    }
  }
}

// @Entry
// @Component
// struct Index {
//   @State message: string = 'Hello World!!';
//
//   build() {
//     Row() {
//       Column() {
//         Text(this.message)
//           .fontSize(50)
//           .fontWeight(FontWeight.Bold)
//       }
//       .width('100%')
//     }
//     .height('100%')
//   }
// }