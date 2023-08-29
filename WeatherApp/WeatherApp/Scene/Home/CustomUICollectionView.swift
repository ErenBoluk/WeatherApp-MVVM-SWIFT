import UIKit

    class CustomCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        
         let cellData: [String] = [
            "1\u{00B0}", "23\u{00B0}", "13\u{00B0}", "44\u{00B0}", "53\u{00B0}", "3\u{00B0}",
            "1\u{00B0}", "2\u{00B0}",  "4\u{00B0}"
         ]

       let cellId = "CustomCell"

       override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
           super.init(frame: frame, collectionViewLayout: layout)
            // Collection view'in ayarlarını yapmak için burayı kullanın.
           // Örneğin, delegeleri ayarlamak, hücre sınıfını kaydetmek ve görünüm özelliklerini ayarlamak.
            setUpCollectionView()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setUpCollectionView() {
            self.delegate = self
            self.dataSource = self

            self.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
            self.backgroundColor = .clear
            // Collection view'in görünümünü özelleştirmek için burada gerekli ayarları yapın.
            // Örneğin, arka plan rengi, hücreler arası boşluk, satır ve sütun sayısı, vb.
        }

        func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: collectionView.frame.width * 0.20 , height: 100 )

        }

        func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // Collection view'da toplamda kaç hücre olacağına karar vermek için döndürülen değeri ayarlayın.
            return 7
        }

        func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            let data = cellData[indexPath.item]
            cell.configure(with: data)
            return cell
        }
        func collectionView( collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print(indexPath.row)
        }

    }
