
module Truty

  # Module with specific Czech typography fixes.
  # @author Matěj Kašpar Jirásek
  module Czech

    # Improves the Czech typography of single paragraph. If you supply more paragraphs you might lose some improvements like widows. For improving longer text see {General#fix}.
    #
    # @param input [String] The paragraph which will be converted.
    # @param convert [Array] Array of symbols with features that should be improved (possibilities: +all+, +hyphens+, +quotes+, +ellipsis+, +dashes+, +abbreviations+, +prepositions+, +numbers+, +dates+, +characters+, +brackets+, +multiplication+, +units+, +widows+)
    # @return [String] Paragraph with improved typography.
    def czech(input, convert = [:all])
      output = input
      output = soft_hyphens(output, "cs") if (convert.include?(:all) || convert.include?(:hyphens))
      output = general(output, convert)
      output = czech_dates(output) if (convert.include?(:all) || convert.include?(:dates))
      output = czech_double_quotes(output) if (convert.include?(:all) || convert.include?(:quotes))
      output = czech_single_quotes(output) if (convert.include?(:all) || convert.include?(:quotes))
      output = czech_long_numbers(output) if (convert.include?(:all) || convert.include?(:numbers))
      output = czech_prepositions(output) if (convert.include?(:all) || convert.include?(:prepositions))
      output = czech_abbreviations(output) if (convert.include?(:all) || convert.include?(:abbreviations))
      output
    end

    # Adds non-breaking space after Czech one character prepostion.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with non-breaking spaces after prepositions.
    def czech_prepositions(input)
      input.gsub(/(\s+|^|\A)(([aikosuvz]\s+)+)/i) { $1 + $2.gsub(/\s+/, " ") }
    end

    # Divides long numbers into parts of three digits using thin space.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with spaces inside of long numbers.
    def czech_long_numbers(input)
      input.gsub(/\d{5,}/) { |n| n.reverse.scan(/(.{1,3})/).join(' ').reverse }
    end

    # Adds non-breaking spaces in and after Czech abbreviations.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with non-breaking spaces in and after abbreviations.
    def czech_abbreviations(input)
      abbreviations = /(\s|^|\Z)(a\. s\.|abl\. |absol\. |adj\. |adm\. |adv\. |aj\.|ak\. |ak\. sl\.|akt\. |alch\. |amer\. |anat\. |angl\. |anglosas\. |ap\.|apod\.|arab\. |arch\. |archit\. |arg\. |arm\. gen\. |astr\. |astrol\. |atd\.|atp\.|att\. |b\. k\.|Bc\. |BcA\. |belg\. |bibl\. |biol\. |bl\. |boh\. |bot\. |br\. |brig\. gen\. |brit\. |bulh\. |bás\. |býv\. |chcsl\. |chem\. |chil\. |CSc\. |csl\. |círk\. |dat\. |dep\. |des\. |dial\. |DiS\.|dl\. |doc\. |dol\. |dop\. |dopr\. |dosl\. |dán\. |dór\. |děj\. |dět\. |ekon\. |epic\. |etnonym\. |eufem\. |ev\. |event\. |f\. |fam\. |fem\. |fil\. |film\. |fin\. |form\. |fot\. |fr\. |fut\. |fyz\. |gen\. |genmjr\. |genplk\. |genpor\. |geogr\. |geol\. |geom\. |germ\. |gram\. |hebr\. |herald\. |hist\. |hl\. |hod\. |hor\. |horn\. |hovor\. |hud\. |hut\. |ie\. |imp\. |impf\. |ind\. |indoevr\. |inf\. |Ing\. |instr\. |interj\. |iron\. |it\. |ión\. |j\. č\.|jap\. |JUDr\. |k\. s\.|kanad\. |katalán\. |klas\. |kniž\. |komp\. |konj\. |konkr\. |kpt\. |kr\. |kuch\. |kř\. |lat\. |les\. |lid\. |lit\. |liturg\. |log\. |lok\. |lék\. |m\. |mat\. |meteor\. |metr\. |MgA\. |Mgr\. |mil\. |mj\. |mjr\. |ml\. |mld\. |mn\. č\.|mod\. |ms\. |MUDr\. |MVDr\. |mysl\. |n\. |n\. l\.|např\. |neklas\. |nesklon\. |než\. |niz\. |nom\. |nor\. |npor\. |nprap\. |nrtm\. |nstržm\. |náb\. |nám\. |námoř\. |něm\. |o\. p\. s\.|o\. s\.|ob\. |obch\. |obyč\. |odd\. |odp\. |ojed\. |opt\. |p\. |p\. n\. l\.|p\. o\.|P\. S\. |P\. T\. |part\. |pas\. |pejor\. |pers\. |pf\. |PharmDr\. |PhDr\. |pl\. |plk\. |plpf\. |po Kr\.|pol\. |pomn\. |popř\. |por\. |pplk\. |ppor\. |pprap\. |prap\. |prep\. |prof\. |práv\. |př\. Kr\.|př\. n\. l\.|před n\. l\.|předl\. |přivl\. |r\. |rak\. |rcsl\. |refl\. |reg\. |resp\. |rkp\. |RNDr\. |roč\. |RSDr\. |rtm\. |rtn\. |rum\. |rus\. |s\. |s\. p\.|s\. r\. o\.|samohl\. |Sb\. |sg\. |sl\. |slang\. |slov\. |souhl\. |spec\. |spol\. s r\. o\.|sport\. |srov\. |st\. |stfr\. |stol\. |str\. |stržm\. |stsl\. |střv\. |subj\. |subst\. |superl\. |sv\. |svob\. |sz\. |t\. r\.|tech\. |telev\. |teol\. |ThDr\. |tis\. |tj\. |trans\. |tur\. |typogr\. |tzn\. |tzv\. |táz\. |v z\.|v\. o\. s\.|v\. r\.|v\. v\. i\.|var\. |vedl\. |verb\. |vl\. jm\. |voj\. |vok\. |vulg\. |vztaž\. |výtv\. |vč\. |vůb\. |z\. s\.|zahr\. |zast\. |zejm\. |zeměd\. |zkr\. |zn\. |zvl\. |zájm\. |zř\. |č\. |č\. j\.|č\. p\. |čas\. |čes\. |čet\. |čj\. |čp\. |čín\. |čís\. |ř\. |řec\. |říj\. |škpt\. |špan\. |šprap\. |št\. prap\. |švýc\. )/i
      input.gsub(abbreviations) { $1 + $2.gsub(/ /, ' ') }
    end

    # Converts single quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct single quotes.
    def czech_single_quotes(input)
      quotes(input, "'`", "‚", "‘")
    end

    # Converts double quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct double quotes.
    def czech_double_quotes(input)
      quotes(input, '"“”„', "„", "“")
    end

    # Adds non-breaking space after number with period.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with non-breaking spaces after numbers.
    def czech_dates(input)
      input.gsub(/((\d+\. )+)/) { $1.gsub(/ /, " ") }
    end

  end
end
