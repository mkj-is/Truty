
module Truty

  # Module with specific Czech typography fixes.
  # @author Matěj Kašpar Jirásek
  module Czech

    # Improves the typography of the large plain text with paragraphs. Adds non-breaking spaces, hyphenation, fixes dashes, etc. Fixes some typography fixes specific for the Czech languages, like one character prepositions, abbreviations and spaces between numbers.
    #
    # @param input [String] The text which will be converted.
    # @return [String] Text with improved typography.
    def fix_czech_text(input)
      input.split("\n").collect { |p| fix_czech_paragraph(p) }.join("\n")
    end

    # Improves the Czech typography of single paragraph. If you supply more paragraphs you might lose some improvements like widows. For improving longer text see {#fix_czech_text}.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with improved typography.
    def fix_czech_paragraph(input)
      output = input
      output = ellipsis(output)
      output = fix_multicharacters(output)
      output = fix_punctuation_whitespace(output)
      output = fix_brackets_whitespace(output)
      output = add_soft_hyphens(output, "cs")
      output = emdash_spaces(output)
      output = endash_spaces(output)
      output = fix_quotes(output, "\"", "„", "“")
      output = fix_quotes(output, "'", "‚", "‘")
      output = fix_multiplication_sign(output)
      output = fix_space_between_numbers(output)
      output = fix_units(output)
      output = fix_trailing_spaces(output)
      output = fix_widows(output)
      output = fix_long_czech_numbers(output)
      output = fix_czech_one_character_words(output)
      output = fix_czech_abbreviations(output)
    end

    # Adds non-breaking space after Czech one character prepostion.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with non-breaking spaces after prepositions.
    def fix_czech_one_character_words(input)
      input.gsub(/(\s+|^|\A)(([aikosuvz]\s+)+)/i) { |prep| $1 + $2.gsub(/\s+/, " ") }
    end

    # Divides long numbers into parts of three digits using thin space.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with spaces inside of long numbers.
    def fix_long_czech_numbers(input)
      input.gsub(/\d+/) { |n| n.reverse.scan(/(.{1,3})/).join(' ').reverse }
    end

    # Adds non-breaking spaces in and after Czech abbreviations.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with non-breaking spaces in and after abbreviations.
    def fix_czech_abbreviations(input)
      abbreviations = /(a. s.|abl. |absol. |adj. |adm. |adv. |aj.|ak. |ak. sl.|akt. |alch. |amer. |anat. |angl. |anglosas. |ap.|apod.|arab. |arch. |archit. |arg. |arm. gen. |astr. |astrol. |atd.|atp.|att. |b. k.|Bc. |BcA. |belg. |bibl. |biol. |bl. |boh. |bot. |br. |brig. gen. |brit. |bulh. |bás. |býv. |chcsl. |chem. |chil. |CSc. |csl. |círk. |dat. |dep. |des. |dial. |DiS.|dl. |doc. |dol. |dop. |dopr. |dosl. |dán. |dór. |děj. |dět. |ekon. |epic. |etnonym. |eufem. |ev. |event. |f. |fam. |fem. |fil. |film. |fin. |form. |fot. |fr. |fut. |fyz. |gen. |genmjr. |genplk. |genpor. |geogr. |geol. |geom. |germ. |gram. |hebr. |herald. |hist. |hl. |hod. |hor. |horn. |hovor. |hud. |hut. |ie. |imp. |impf. |ind. |indoevr. |inf. |Ing. |instr. |interj. |iron. |it. |ión. |j. č.|jap. |JUDr. |k. s.|kanad. |katalán. |klas. |kniž. |komp. |konj. |konkr. |kpt. |kr. |kuch. |kř. |lat. |les. |lid. |lit. |liturg. |log. |lok. |lék. |m. |mat. |meteor. |metr. |MgA. |Mgr. |mil. |mj. |mjr. |ml. |mld. |mn. č.|mod. |ms. |MUDr. |MVDr. |mysl. |n. |n. l.|např. |neklas. |nesklon. |než. |niz. |nom. |nor. |npor. |nprap. |nrtm. |nstržm. |náb. |nám. |námoř. |něm. |o. p. s.|o. s.|ob. |obch. |obyč. |odd. |odp. |ojed. |opt. |p. |p. n. l.|p. o.|P. S. |P. T. |part. |pas. |pejor. |pers. |pf. |PharmDr. |PhDr. |pl. |plk. |plpf. |po Kr.|pol. |pomn. |popř. |por. |pplk. |ppor. |pprap. |prap. |prep. |prof. |práv. |př. Kr.|př. n. l.|před n. l.|předl. |přivl. |r. |rak. |rcsl. |refl. |reg. |resp. |rkp. |RNDr. |roč. |RSDr. |rtm. |rtn. |rum. |rus. |s. |s. p.|s. r. o.|samohl. |Sb. |sg. |sl. |slang. |slov. |souhl. |spec. |spol. s r. o.|sport. |srov. |st. |stfr. |stol. |str. |stržm. |stsl. |střv. |subj. |subst. |superl. |sv. |svob. |sz. |t. r.|tech. |telev. |teol. |ThDr. |tis. |tj. |trans. |tur. |typogr. |tzn. |tzv. |táz. |v z.|v. o. s.|v. r.|v. v. i.|var. |vedl. |verb. |vl. jm. |voj. |vok. |vulg. |vztaž. |výtv. |vč. |vůb. |z. s.|zahr. |zast. |zejm. |zeměd. |zkr. |zn. |zvl. |zájm. |zř. |č. |č. j.|č. p. |čas. |čes. |čet. |čj. |čp. |čín. |čís. |ř. |řec. |říj. |škpt. |špan. |šprap. |št. prap. |švýc. )/i
      input.gsub(abbreviations) { |abbr| abbr.gsub(/ /, ' ') }
    end

  end
end
