require ["fileinto", "imap4flags"];

/**
 * Safe flags - \Flagged \Deleted \Seen
 */

/**
 * Send MF statements to folder
 * Send MF mails to catchall folder
 */

if address :domain :is "From" ["camsmf.com","camsonline.com", "kfintech.com","abfss.adityabirlacapital.org","adityabirlacapital.com","axismf.com","canararobeco.com","emkt.franklintempleton.com","franklintempleton.com","kotak-amc.com","kotakmf.com","lntmf.co.in","ltfs.com","motilaloswal.com","ppfas.com","ppfas.in","dspim.com","wintwealth.com","updates.wintwealth.com","info.wintwealth.com"] {
    if address :all :is "From" "accountstatement@axismf.com" {
        fileinto "Investments/Statements";
    } elsif header :contains "subject" "statement" {
        fileinto "Investments/Statements";
    } else {
        fileinto "Investments";
    }
}

/**
 * Send bank statements to folder
 */
if address :all :is "From" [
    "statements@axisbank.com",
    "hdfcbanksmartstatement@hdfcbank.net",
    "estatement@icicibank.com",
    "estatement2@punjabnationalbank.in"
    ] {
    fileinto "Banking/Statements";
} elsif address :domain :is "From" ["axisbank.com", "hdfcbank.net", "hdfcbank.com", "icicibank.com", "custcomm.icicibank.com"] {
    fileinto "Banking";
}

/**
 * Send credit card statements to folder
 */
if anyof(
    address :all :is "From" "net.statement@citicorp.com",
    allof(
        address :domain :is "From" ["americanexpress.co.uk", "americanexpress.com"],
        header :contains "subject" "Your latest statement is ready"
    ) )
    {
        fileinto "Credit card/Statements";
    }
    elsif address :domain :is "From" ["citicorp.com","email.americanexpress.com","welcome.americanexpress.com","americanexpress.co.uk"]
    {
        fileinto "Credit card";
    }

/**
 * Insurance stuff
 */
if anyof(
    address :domain :is "From" ["hdfclife.com","hdfclife.in","hdfclife.biz","licindia.com","retailmarketing.hdfclife.com"],
    address :all :is "From" "nir@nsdl.com")
    {
        fileinto "Insurance";
    }

/**
 * DEV stuff
 */
if address :domain :is "From" ["github.com","gitlab.com","mg.gitlab.com"]
{
    fileinto "Software";
}

/**
 * Music stuff
 */
if anyof(
    address :domain :is "From" "bandcamp.com",
    allof(
        exists "Authentication-Results",
        header :comparator "i;unicode-casemap" :contains "Authentication-Results" "header.i=@songkick.com")
    )
    {
        fileinto "Music";
    }

/**
 * Star job application responses
 */
if header :comparator "i;unicode-casemap" :contains "subject" "Thank you for applying"
{
    addflag "\\Flagged";
}

/**
 * SPAM Control - A little too strict
elsif anyof(
  header :contains "Authentication-Results" "dkim=fail",
  header :contains "Authentication-Results" "spf=fail")
  {
    fileinto "Junk";
    stop;
  }
*/
