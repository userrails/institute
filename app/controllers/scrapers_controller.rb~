class ScrapersController < ApplicationController

  def scrap1
  company = [
      "Ministry of transportation","Burlington coat factory"]

    company.each do |business|
      url = "http://www.yelp.com/search?find_desc=#{business.split(' ').join('+')}&find_loc=Edmonton%2C+AB&ns=1"
      #      url = "http://www.yelp.com/search?find_desc=#{business.split(' ').join('+')}&find_loc=#{business.city.split(' ').join('+')}%2C+#{business.province}&ns=1"

      data = Nokogiri::HTML(open(url,'User-Agent' => 'ruby'))

      # Here is where we use the new method to create an object that holds all the
      # concert listings.  Think of it as an array that we can loop through.  It's
      # not an array, but it does respond very similarly.
      concerts = data.css('ul.ylist.ylist-bordered.search-results li')

      concerts.each do |concert|
        link = concert.css('div').css('div.clearfix.media-block.main-attributes').css('div.media-story').css("h3 a")[0]["href"]
        #      puts concert.css('div').css('div.secondary-attributes').css('span.biz-phone').text
        url1 = "http://www.yelp.com/"+link

        data1 = Nokogiri::HTML(open(url1,'User-Agent' => 'ruby'))
        concerts1 = data1.css('div#bizBox')
        concerts1.each do |concert|
          c_name = concert.css("div#bizInfoBody div.wrap").css('div#bizInfoHeader h1').text.strip
          cate = concert.css("div#bizInfoBody div#bizInfoContent").css('p#bizCategories span#cat_display').text.split(',').join(',').strip if concert.css("div#bizInfoBody div#bizInfoContent").css('p#bizCategories span#cat_display') != nil
          address =  concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[0].text if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[0] != nil
          city = concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[1].text if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[1] != nil
          provience = concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[2].text if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[2] != nil
          postalcode = concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[3].text.split(' ').join('') if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[3] != nil
          ph_no = concert.css("div#bizInfoBody div#bizInfoContent").css('span#bizPhone').text if concert.css("div#bizInfoBody div#bizInfoContent").css('span#bizPhone') != nil
          url = concert.css("div#bizInfoBody div#bizInfoContent").css('div#bizUrl a').text if concert.css("div#bizInfoBody div#bizInfoContent").css('div#bizUrl')[0] != nil
          if !ScrapBusiness.exists?(:company_name => c_name,:zipcode => postalcode)
            #          @lat_bus = ScrapBusiness.new(:address =>address,:city => city,:company_name => c_name,:categories => cate,:phone_no =>ph_no,:province => provience,:zipcode => postalcode,:url => url, :csv_business_id => business.id)
            @lat_bus = ScrapBusiness.new(:address =>address,:city => city,:company_name => c_name,:categories => cate,:phone_no =>ph_no,:province => provience,:zipcode => postalcode,:url => url)
            @lat_bus.save
            concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').empty?
            if concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').empty? == false
              concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').each do |h|
                h.text.split(', ').count
                if h.text.split(', ').count != 2
                  if h.text.split(' ', 2)[0].split('-').count > 1
                    array = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
                    i = array.index("#{h.text.split(' ', 2)[0].split('-')[0]}")
                    j = array.index("#{h.text.split(' ', 2)[0].split('-')[1]}")
                    if h.text.split(' ', 2)[1].split('-')[0].split(':').count > 1
                      from =  h.text.split(' ', 2)[1].split('-')[0].split(' ').join('')
                    else
                      from = h.text.split(' ', 2)[1].split('-')[0].split(' ').join(':00')
                    end
                    if h.text.split(' ', 2)[1].split('-')[1].split(':').count > 1
                      to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                    else
                      to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                    end
                    array[i..j].each do |day|
                      day1 = day.downcase+"_from"
                      day2 = day.downcase+"_to"
                      @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                    end
                  else
                    day = h.text.split(' ', 2)[0]
                    if h.text.split(' ', 2)[1].split('-')[0].split(':').count > 1
                      from1 =  h.text.split(' ', 2)[1].split('-')[0].split(' ').join('')
                    else
                      from1 = h.text.split(' ', 2)[1].split('-')[0].split(' ').join(':00')
                    end
                    if h.text.split(' ', 2)[1].split('-')[1].split(':').count > 1
                      to1 = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                    else
                      to1 = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                    end
                    day1 = day.downcase+"_from"
                    day2 = day.downcase+"_to"
                    @lat_bus.update_attributes("#{day1.split(",").join('')}" => from1,"#{day2.split(",").join('')}" => to1)
                  end
                else
                  array = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
                  if h.text.split(', ',2)[1].split(" ",2).last.split('-')[0].split(':').count > 1
                    from =  h.text.split(' ', 2)[1].split(" ",2).last.split('-')[0].split(' ').join('')
                  else
                    from = h.text.split(' ', 2)[1].split(" ",2).last.split('-')[0].split(' ').join(':00')
                  end
                  if h.text.split(', ')[1].split(" ",2).last.split('-')[1].split(':').count > 1
                    to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                  else
                    to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                  end
                  if h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                    i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                    j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                    array[i..j].each do |day|
                      day1 = day.downcase+"_from"
                      day2 = day.downcase+"_to"
                      @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                    end

                    k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                    l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                    array[k..l].each do |day|
                      day3 = day.downcase+"_from"
                      day4 = day.downcase+"_to"
                      @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                    end
                  elsif h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count != 2
                    i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                    j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                    array[i..j].each do |day|
                      day1 = day.downcase+"_from"
                      day2 = day.downcase+"_to"
                      @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                    end

                    day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                    day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                    @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                  elsif h.text.split(', ',2)[0].split("-").count != 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                    k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                    l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                    array[k..l].each do |day|
                      day1 = day.downcase+"_from"
                      day2 = day.downcase+"_to"
                      @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                    end

                  elsif h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count != 2
                    i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                    j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                    array[i..j].each do |day|
                      day1 = day.downcase+"_from"
                      day2 = day.downcase+"_to"
                      @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                    end

                    day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                    day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                    @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                  elsif h.text.split(', ',2)[0].split("-").count != 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                    k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                    l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                    array[k..l].each do |day|
                      day1 = day.downcase+"_from"
                      day2 = day.downcase+"_to"
                      @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                    end

                    day3 = h.text.split(', ',2)[0].downcase+"_from"
                    day4 = h.text.split(', ',2)[0].downcase+"_to"
                    @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                  else h.text.split(', ',2)[1].split("-").count != 2
                    day1 = h.text.split(', ',2)[0].downcase+"_from"
                    day2 = h.text.split(', ',2)[0].downcase+"_to"
                    day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                    day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                    @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to,"#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                  end
                end
              end
            end
          end
        end
      end
    end
  end


  def scraptiming #this scrap the business name and records inserted into the table
    @companies=CsvBusiness.limit(1)
    @companies.each do |business|
      # url = "http://www.yelp.com/search?find_desc=#{business.split(' ').join('+')}&find_loc=Edmonton%2C+AB&ns=1"
      url = "http://www.yelp.com/search?find_desc=#{business.company_name.split(' ').join('+')}&find_loc=#{business.city.split(' ').join('+')}%2C+#{business.province}&ns=1"
      data = Nokogiri::HTML(open(url,'User-Agent' => 'ruby'))
      # Here is where we use the new method to create an object that holds all the
      # concert listings.  Think of it as an array that we can loop through.  It's
      # not an array, but it does respond very similarly.
      concerts = data.css('ul.ylist.ylist-bordered.search-results li')
      concerts.each do |concert|
        link = concert.css('div').css('div.clearfix.media-block.main-attributes').css('div.media-story').css("h3 a")[0]["href"]
        #      puts concert.css('div').css('div.secondary-attributes').css('span.biz-phone').text
        url1 = "http://www.yelp.com/"+link

        data1 = Nokogiri::HTML(open(url1,'User-Agent' => 'ruby'))
        concerts1 = data1.css('div#bizBox')
        if concerts1.css("div#bizInfoBody div.wrap").css('div#bizInfoHeader h1').text.strip.downcase.scan("#{business.company_name.downcase}").empty? != true
          if (business.province == (concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[2] != nil ? concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[2].text : '0') and (business.city.downcase == (concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[1] != nil ? concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[1].text.downcase : '0')) and (business.zipcode == (concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[3] != nil ? concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[3].text.split(' ').join('') : '0')))
            concerts1.each do |concert|
              c_name = concert.css("div#bizInfoBody div.wrap").css('div#bizInfoHeader h1').text.strip
              cate = concert.css("div#bizInfoBody div#bizInfoContent").css('p#bizCategories span#cat_display').text.split(',').join(',').strip if concert.css("div#bizInfoBody div#bizInfoContent").css('p#bizCategories span#cat_display') != nil
              address =  concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[0].text if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[0] != nil
              city = concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[1].text if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[1] != nil
              provience = concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[2].text if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[2] != nil
              postalcode = concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[3].text.split(' ').join('') if concert.css("div#bizInfoBody div#bizInfoContent").css('address span')[3] != nil
              ph_no = concert.css("div#bizInfoBody div#bizInfoContent").css('span#bizPhone').text if concert.css("div#bizInfoBody div#bizInfoContent").css('span#bizPhone') != nil
              url = concert.css("div#bizInfoBody div#bizInfoContent").css('div#bizUrl a').text if concert.css("div#bizInfoBody div#bizInfoContent").css('div#bizUrl')[0] != nil
              if !ScrapBusiness.exists?(:company_name => c_name,:zipcode => postalcode)
                #          @lat_bus = ScrapBusiness.new(:address =>address,:city => city,:company_name => c_name,:categories => cate,:phone_no =>ph_no,:province => provience,:zipcode => postalcode,:url => url, :csv_business_id => business.id)
                @lat_bus = ScrapBusiness.new(:address =>address,:city => city,:company_name => c_name,:categories => cate,:phone_no =>ph_no,:province => provience,:zipcode => postalcode,:url => url)
                @lat_bus.save
                concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').empty?
                if concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').empty? == false
                  concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').each do |h|
                    h.text.split(', ').count
                    if h.text.split(', ').count != 2
                      if h.text.split(' ', 2)[0].split('-').count > 1
                        array = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
                        i = array.index("#{h.text.split(' ', 2)[0].split('-')[0]}")
                        j = array.index("#{h.text.split(' ', 2)[0].split('-')[1]}")
                        if h.text.split(' ', 2)[1].split('-')[0].split(':').count > 1
                          from =  h.text.split(' ', 2)[1].split('-')[0].split(' ').join('')
                        else
                          from = h.text.split(' ', 2)[1].split('-')[0].split(' ').join(':00')
                        end
                        if h.text.split(' ', 2)[1].split('-')[1].split(':').count > 1
                          to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                        else
                          to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                        end
                        array[i..j].each do |day|
                          day1 = day.downcase+"_from"
                          day2 = day.downcase+"_to"
                          @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                        end
                      else
                        day = h.text.split(' ', 2)[0]
                        if h.text.split(' ', 2)[1].split('-')[0].split(':').count > 1
                          from1 =  h.text.split(' ', 2)[1].split('-')[0].split(' ').join('')
                        else
                          from1 = h.text.split(' ', 2)[1].split('-')[0].split(' ').join(':00')
                        end
                        if h.text.split(' ', 2)[1].split('-')[1].split(':').count > 1
                          to1 = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                        else
                          to1 = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                        end
                        day1 = day.downcase+"_from"
                        day2 = day.downcase+"_to"
                        @lat_bus.update_attributes("#{day1.split(",").join('')}" => from1,"#{day2.split(",").join('')}" => to1)
                      end
                    else
                      array = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
                      if h.text.split(', ',2)[1].split(" ",2).last.split('-')[0].split(':').count > 1
                        from =  h.text.split(' ', 2)[1].split(" ",2).last.split('-')[0].split(' ').join('')
                      else
                        from = h.text.split(' ', 2)[1].split(" ",2).last.split('-')[0].split(' ').join(':00')
                      end
                      if h.text.split(', ')[1].split(" ",2).last.split('-')[1].split(':').count > 1
                        to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                      else
                        to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                      end
                      if h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                        i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                        j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                        array[i..j].each do |day|
                          day1 = day.downcase+"_from"
                          day2 = day.downcase+"_to"
                          @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                        end

                        k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                        l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                        array[k..l].each do |day|
                          day3 = day.downcase+"_from"
                          day4 = day.downcase+"_to"
                          @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                        end
                      elsif h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count != 2
                        i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                        j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                        array[i..j].each do |day|
                          day1 = day.downcase+"_from"
                          day2 = day.downcase+"_to"
                          @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                        end

                        day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                        day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                        @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                      elsif h.text.split(', ',2)[0].split("-").count != 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                        k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                        l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                        array[k..l].each do |day|
                          day1 = day.downcase+"_from"
                          day2 = day.downcase+"_to"
                          @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                        end

                      elsif h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count != 2
                        i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                        j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                        array[i..j].each do |day|
                          day1 = day.downcase+"_from"
                          day2 = day.downcase+"_to"
                          @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                        end

                        day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                        day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                        @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                      elsif h.text.split(', ',2)[0].split("-").count != 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                        k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                        l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                        array[k..l].each do |day|
                          day1 = day.downcase+"_from"
                          day2 = day.downcase+"_to"
                          @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                        end

                        day3 = h.text.split(', ',2)[0].downcase+"_from"
                        day4 = h.text.split(', ',2)[0].downcase+"_to"
                        @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                      else h.text.split(', ',2)[1].split("-").count != 2
                        day1 = h.text.split(', ',2)[0].downcase+"_from"
                        day2 = h.text.split(', ',2)[0].downcase+"_to"
                        day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                        day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                        @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to,"#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

end
