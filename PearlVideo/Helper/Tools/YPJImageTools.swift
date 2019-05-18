//
//  YPJImageTools.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/17.
//  Copyright © 2019 equalriver. All rights reserved.
//

public struct YPJImageTools<T>: YPJToolable {
    
    public let ypj: T
    
    public init(target: T) {
        self.ypj = target
    }
}

extension UIImage: YPJToolable {
    
    public var ypj: YPJImageTools<UIImage> {
        return YPJImageTools.init(target: self)
    }
}

extension YPJImageTools where YPJToolType == UIImage {
    
    //MARK: - 图片转成Base64
    ///图片转成Base64字符串
    public var base64String: String {
        let data = ypj.jpegData(compressionQuality: 1.0)
        let str = data?.base64EncodedString() ?? ""
        //        let str = data?.base64EncodedString(options: .lineLength64Characters)
        return "data:image/jpeg;base64," + str
    }
    
    //MARK: - 异步绘制圆角
    ///异步绘制圆角
    public func asyncDrawCornerRadius(roundedRect: CGRect, cornerRadius: CGFloat, fillColor: UIColor, callback: @escaping (_ img: UIImage?) -> Void) {
        
        DispatchQueue.global().async {
            // 1.利用绘图，建立上下文 - 内存中开辟一个地址，跟屏幕无关!
            /**
             参数：
             1> size: 绘图的尺寸
             2> 不透明：false / true
             3> scale：屏幕分辨率，生成的图片默认使用 1.0 的分辨率，图像质量不好;可以指定 0 ，会选择当前设备的屏幕分辨率
             */
            UIGraphicsBeginImageContextWithOptions(roundedRect.size, true, 0)
            
            // 2.设置被裁切的部分的填充颜色
            fillColor.setFill()
            UIRectFill(roundedRect)
            
            
            // 3.利用 贝塞尔路径 实现 裁切 效果
            // 1>实例化一个圆形的路径
            let path = UIBezierPath.init(roundedRect: roundedRect, cornerRadius: cornerRadius)
            // 2>进行路径裁切 - 后续的绘图，都会出现在圆形路径内部，外部的全部干掉
            path.addClip()
            
            // 4.绘图 drawInRect 就是在指定区域内拉伸屏幕
            self.ypj.draw(in: roundedRect)
            /*
             // 5.绘制内切的圆形
             let ovalPath = UIBezierPath.init(ovalIn: rect)
             ovalPath.lineWidth = 2
             lineColor.setStroke()
             ovalPath.stroke()
             //        UIColor.darkGray.setStroke()
             //        path.lineWidth = 2
             //        path.stroke()
             */
            // 6.取得结果
            let result = UIGraphicsGetImageFromCurrentImageContext()
            
            // 7.关闭上下文
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                callback(result)
            }
        }
    }
    
    //MARK: - 绘制图片圆角
    ///绘制图片圆角
    func drawCorner(rect: CGRect, cornerRadius: CGFloat) -> UIImage {
        
        let bezierPath = UIBezierPath.init(roundedRect: rect, cornerRadius: cornerRadius)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.addPath(bezierPath.cgPath)
            context.clip()
            self.ypj.draw(in: rect)
            context.drawPath(using: CGPathDrawingMode.fillStroke)
            if let img = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                return img
            }
        }
        return UIImage()
        
    }
    
    //MARK: - 裁剪图片
    ///裁剪图片
    func clipImage(newRect: CGRect) -> UIImage? {
        //将UIImage转换成CGImage
        let sourceImg = self.ypj.cgImage
        
        //按照给定的矩形区域进行剪裁  //cropping以图片px为单位
        guard let newCgImg = sourceImg?.cropping(to: newRect) else { return nil }
        
        //将CGImageRef转换成UIImage
        let newImg = UIImage.init(cgImage: newCgImg)
        
        return newImg
    }
    
    //MARK: - 自适应裁剪
    ///自适应裁剪
    func clipImageToRect(newSize: CGSize) -> UIImage? {
        
        //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
        if self.ypj.size.width * newSize.height <= self.ypj.size.height * newSize.width {
            //以被剪裁图片的宽度为基准，得到剪切范围的大小
            let w = self.ypj.size.width
            let h = self.ypj.size.width * newSize.height / newSize.width
            // 调用剪切方法
            // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
            return self.clipImage(newRect: CGRect.init(x: 0, y: (self.ypj.size.height - h) / 2, width: w, height: h))
        }
        else {//被切图片宽比例比高比例大，以图片高进行剪裁
            // 以被剪切图片的高度为基准，得到剪切范围的大小
            let w = self.ypj.size.height * newSize.width / newSize.height
            let h = self.ypj.size.height
            // 调用剪切方法
            // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
            return self.clipImage(newRect: CGRect.init(x: (self.ypj.size.width - w) / 2, y: 0, width: w, height: h))
        }
        
    }
    
    //MARK: - 压缩图片
    ///压缩图片
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(maxLength: Int) -> Data? {
        
        var compress: CGFloat = 0.5
        
        var data = self.ypj.jpegData(compressionQuality: compress)
        
        guard data != nil else { return nil }
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = self.ypj.jpegData(compressionQuality: compress)
        }
        
        return data
    }
    
    //MARK: - 等比例的图片
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = self.ypj.size.width
        let height = self.ypj.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    //MARK: - 指定size的图片
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    func resizeImage(newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, true, UIScreen.main.scale)
        self.ypj.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func saveImageToLocalFolder(directory: FileManager.SearchPathDirectory, compressionQuality: CGFloat) -> String? {
        guard let data = ypj.jpegData(compressionQuality: compressionQuality) else {
            print("图片转data失败")
            return nil
        }
        let p = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)
        guard let path = p.first else { return nil }
        
        let imgCacheFolderPath = path + "/videoImageCache/"
        let imgAbsolutePath = imgCacheFolderPath + "/" + ypj.description.ypj.MD5 + ".jpg"
        
        if FileManager.default.fileExists(atPath: imgCacheFolderPath) == false {
            do {
                try FileManager.default.createDirectory(atPath: imgCacheFolderPath, withIntermediateDirectories: true, attributes: nil)
            }catch {
                print(error)
                return nil
            }
            do {
                try data.write(to: URL.init(fileURLWithPath: imgAbsolutePath))
                return imgAbsolutePath
                
            } catch {
                print(error)
                return nil
            }
        }
        else { return imgAbsolutePath }
    
    }
    
    
}
