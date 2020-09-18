From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 RESEND +TRIVIAL] hexagon: fix punctuation in SMP Kconfig
 help text
Date: Thu, 17 Sep 2020 19:13:49 -0700
Message-ID: <74b18943-7e57-9eae-fec3-d9f83cfb7862@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MTBEQQc8z+hHIyvPKMuXIo95gbEfyZK1ljgIh8WDqpk=; b=GQMz+Vjns4H0IdjtD9CkVY4+gQ
        gSlkHxnl75OwTD0eFG25bAyc5mK/tqZkP3DtjkhqT4h2iSXH7UkVgHJxuR+9hnNXBiH9XOl4GpVt8
        G+EktKgApInEGWvMz8lliXLqmaHzrFBPincQCAe0rfHKK7t1Ynr18rQc0j+cZa/sUcjVJOLPl4YqI
        T+R274Br3UkTtCyoY1YWObTzx+9M0EVQVJrwUZ1JyonXidNJP+n/PtEf91/far4uFyZ83DHdgo7ZJ
        t0tZeFKo3ddWSvjpYyEpCn1E5CzoPXx88qqzQb71Dsy2lz/4dB0Ts3Hz2piyqEKINTle11Le35+bR
        5BMEgMRA==;
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>
Cc: Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

End a sentence with a period ('.') in SMP help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>
---
v2: rebase from JAN-2020 to current.

 arch/hexagon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200917.orig/arch/hexagon/Kconfig
+++ linux-next-20200917/arch/hexagon/Kconfig
@@ -106,7 +106,7 @@ config CMDLINE
 config SMP
 	bool "Multi-Processing support"
 	help
-	  Enables SMP support in the kernel.  If unsure, say "Y"
+	  Enables SMP support in the kernel.  If unsure, say "Y".
 
 config NR_CPUS
 	int "Maximum number of CPUs" if SMP

