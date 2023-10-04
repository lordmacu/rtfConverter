<?php

/**
 * Remove specified RTF keywords and their accompanying commands from an RTF string.
 * Also replaces special character sequences with their Unicode equivalent.
 *
 * @param string $inputText The original RTF string.
 * @param array $keywords List of RTF keywords to remove.
 * @return string The cleaned string.
 */
function removeRtfKeywords(string $inputText, array $keywords): string {
    $cleaned_text = $inputText;

    foreach ($keywords as $keyword) {
        // Escape special characters in the keyword
        $escaped_keyword = preg_quote($keyword, '/');

        // Create the regular expression
        $reg_exp = "/\\\\(" . $escaped_keyword . ")([^\\s\\\\{}]*|\\s?)/";

        // Replace in the text
        $cleaned_text = preg_replace($reg_exp, '', $cleaned_text);
    }

    // Convert special sequences to their Unicode equivalent
    $special_chars_map = [
        "\\\\'e1" => 'á',
        "\\\\'e9" => 'é',
        "\\\\'ed" => 'í',
        "\\\\'f3" => 'ó',
        "\\\\'fa" => 'ú',
        "\\\\'c1" => 'Á',
        "\\\\'c9" => 'É',
        "\\\\'cd" => 'Í',
        "\\\\'d3" => 'Ó',
        "\\\\'da" => 'Ú',
        "\\\\'bf" => '¿',
        "\\\\'f1" => 'ñ',
        "\\\\'d1" => 'Ñ',
        "\\\\'a1" => '¡',
        "\\\\'ab" => '«',
        "\\\\'bb" => '»',
        "{ \\[a-zA-Z]}" => ''
    ];

    foreach ($special_chars_map as $key => $value) {
        $cleaned_text = str_replace($key, $value, $cleaned_text);
    }

    return $cleaned_text;
}

// Usage example
$rtf_keywords = ['par', 'qc', 'fs28', 'fs', 'b', 'cf', 'super'];
$text = "\\par{\\qc\\b\\fs28 La libertad del creyente\\par} \\'abTodo est\\'e1 permitido\\'bb, pero no todo es provechoso. \\'abTodo est\\'e1 permitido\\'bb, pero no todo es constructivo.";

$cleaned_text = removeRtfKeywords($text, $rtf_keywords);

echo "Original: " . $text . PHP_EOL;
echo "Modified: " . $cleaned_text . PHP_EOL;

?>
