From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
Date: Mon, 29 May 2023 16:43:37 +0530
Message-ID: <20230529111337.352990-2-maninder1.s@samsung.com>
References: <20230529111337.352990-1-maninder1.s@samsung.com>
        <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230529111414epoutp04db6805735af14b31b8be8486e7d5434f~jmPLjORx80787107871epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685358854;
        bh=nFYqgya5b+48MlA+S9yA8hdVhuiXp1AXTaJCiqdhPwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOgFM1V4qcZwZ8vsBMA9LoLMlgoUuETPxncFK0SPdVCsjw1Ghx4aV0gt6P9mGf+Jk
         8YZIpUbAMRsFzlq+9S+afpr/CFYG8takm7gMaysfH1LA3pJdfsGvyO7vQs+zEw/uQP
         B3QWof1Kk/R6WCAUjprorl8fuvlEO0jLBtcHQoZ0=
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com, wedsonaf@google.com
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Maninder Singh <maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>

kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
writes on index "KSYM_NAME_LEN - 1".

Thus array size should be KSYM_NAME_LEN.

for powerpc it was defined as "128" directly.
and commit '61968dbc2d5d' changed define value to 512,
So both were missed to update with new size.

Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 728d3c257e4a..70c4c59a1a8f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -88,7 +88,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];
-- 
2.17.1

