//
//  PVRefresh.swift

import MJRefresh
import Foundation

class PVRefresh: NSObject {
    public class func headerRefresh(scrollView: UIScrollView, handle: @escaping () -> Void) {
        
        let headerRef = MJRefreshNormalHeader.init {
            
            //check login
            if UserDefaults.standard.string(forKey: kToken) != nil && YPJOtherTool.ypj.checkNetwork() == true {
                handle()
            }
            if scrollView.mj_header != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    scrollView.mj_header.endRefreshing()
                })
            }
            
        }
        headerRef?.lastUpdatedTimeLabel.isHidden = true
        headerRef?.tintColor = UIColor.white
        headerRef?.activityIndicatorViewStyle = .white
        //        headerRef?.setTitle("下拉刷新", for: .idle)
        //        headerRef?.setTitle("释放更新", for: .pulling)
        //        headerRef?.setTitle("加载中...", for: .refreshing)
        headerRef?.stateLabel.isHidden = true
      
//                var imgs = Array<UIImage>()
//        
//                for v in 1...30 {
//                    if let img = UIImage.init(named: "图层\(v)") {
//                        imgs.append(img)
//                    }
//                }
//                headerRef?.setImages([#imageLiteral(resourceName: "图层1")], duration: 2, for: MJRefreshState.idle)
//                headerRef?.setImages([#imageLiteral(resourceName: "图层15")], duration: 2, for: MJRefreshState.pulling)
//                headerRef?.setImages(imgs, duration: 1, for: MJRefreshState.refreshing)
        
        scrollView.mj_header = headerRef
    }
    
    public class func footerRefresh(scrollView: UIScrollView, handle: @escaping () -> Void) {
        
        let footerRef = MJRefreshBackNormalFooter.init {
            
            //check login
            if UserDefaults.standard.string(forKey: kToken) != nil && YPJOtherTool.ypj.checkNetwork() == true {
                handle()
            }
            
        }
        footerRef?.backgroundColor = kColor_deepBackground
        footerRef?.tintColor = kColor_subText
        footerRef?.setTitle("上拉加载更多", for: .idle)
        footerRef?.setTitle("正在加载数据...", for: .refreshing)
        footerRef?.setTitle("没有更多了", for: .noMoreData)
        
        scrollView.mj_footer = footerRef
    }
}
