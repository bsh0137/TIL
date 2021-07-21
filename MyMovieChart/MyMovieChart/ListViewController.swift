import UIKit

class ListViewController: UITableViewController {

    @IBOutlet var moreBtn: UIButton!
    // 현재까지 읽어온 데이터의 페이지 정보
    var page = 1
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    override func viewDidLoad() {
        // 호핀 API 호출을 위한 URI 생성
        self.callMovieAPI()
    }
    
    func getThumbnailImage(_ index: Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴.
        let mvo = self.list[index]
        
        // 메모이제이션 : 저장된 이미지가 있으면 그것을 반환하고, 없을 경우 내려받아 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData)
            
            return mvo.thumbnailImage!
        }
    }
    
    func callMovieAPI() {
        // 영화 차트 API를 호출함.
        let url =
        "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(page)&count=10&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        // REST API 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        print(apidata)
        // 데이터 전송 결과를 로그로 출력(반드시 필요한 코드는 아님)
//        let log = String(data:apidata, encoding: .utf8) ?? ""
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result=\( log )")
        
        
        // JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            // 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            // Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트르 구성할 데이터 형식
                let mvo = MovieVO()
                
                // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data:imageData)
                
                // List 배열에 추가.
                self.list.append(mvo)
                
                // 전체 데이터 카운트를 얻는다.
                let totalCount = ((hoppin["totalCount"] as? NSString)!.integerValue)
                
                // totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다.
                if (self.list.count >= totalCount) {
                    self.moreBtn.isHidden = true
                    NSLog("It's last page!")
                }
            }
        } catch { NSLog("Parse Error!!") }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
        
        NSLog("Test \(row.title!), \(indexPath.row)")
        
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        

        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
        // 비동기 방식으로 썸네일 이미지를 읽어옴
        DispatchQueue.main.async(execute: {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        })
        
//        // 썸네일 경로를 인자값으로 하는 URL 객체를 생성
//        let url: URL! = URL(string: row.thumbnail!)
//
//        // 이미지를 읽어와 Data 객체에 저장
//        let imageData = try! Data(contentsOf: url)
//
//        //UIImage 객체를 생성하여 아울렛 변수의 image 속성에 대입
//        cell.thumbnail.image = UIImage(data:imageData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath) 번째 행입니다.")
    }
    
    @IBAction func more(_ sender: Any) {
        // 현재 페이지 값에 1을 추가한다.
        self.page += 1
        
        self.callMovieAPI()
        
        self.tableView.reloadData()
    }
    
}


// MARK: - 화면 전환 시 값을 넘겨주기 위한 세그웨이 관련 처리
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행된 세그웨이의 식별자가 "segue_detail"이라면
        if segue.identifier == "segue_detail" {
            // 사용자가 클릭한 행을 찾아낸다.
            let path = self.tableView.indexPath(for: sender as! MovieCell)
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
        }
    }
    
}
