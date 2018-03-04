module ApplicationHelper
require 'csv'
  def self.get_csv
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    options.binary = chrome_bin_path if chrome_bin_path

    driver = Selenium::WebDriver.for(:chrome, options: options)

    url = "https://booking.ilovetour.co.uk/your-group-details.php?%2B7a%2B7JQtiWekTsKJPym01Ft3tieYQKFsHY%2BHvidNUA%2Fx%2Bn9RZQIAJvy%2B8S%2BmIf5H0eWdkjnzh3ZrUyu%2BAGH710PQMx2CR8qTez0b4NTTGDBzA0VsUTHjDT1V8lbc"
    driver.get(url)

    driver.find_element(:id, 'uname').send_keys ENV['USERNAME']
    driver.find_element(:id, 'upass').send_keys ENV['PASS']

    driver.find_elements(:class, "ilt_login_submit")[0].click
    doc1 = driver.page_source
    driver.close

    doc = Nokogiri::HTML(doc1)

    csv = CSV.open("output.csv", 'w', {:col_sep => ",", :force_quotes => true, skip_blanks: true})
    doc.xpath('//table/tbody/tr').each do |row|
      tarray = []
      row.xpath('td').each do |cell|
        tarray << cell.text
      end
      csv << tarray
    end

    csv.close
  end
end
