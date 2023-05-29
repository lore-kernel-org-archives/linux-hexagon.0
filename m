From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/2] hexagon/traps.c: use KSYM_NAME_LEN in array size
Date: Mon, 29 May 2023 16:43:36 +0530
Message-ID: <20230529111337.352990-1-maninder1.s@samsung.com>
References: <CGME20230529111350epcas5p46a1fa16ffb2a39008c26d03c5c63f109@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230529111410epoutp031e35df3800b3177a8d679cf6448c266d~jmPIQB34v0906609066epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685358851;
        bh=qk7FA9xN87p6FJZ2Z10A3WhlL1LEP+O+6ySBHhTKuX4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DND7sJm2sq7q4rMerIdycPSPVQhLOtjeo4UpHceABdHDMumw7lLeFu5rZr0TW5miU
         YTCB9E5fqUw4QfL5OABuXth+WI95Ebm2rPVRT/dQ1vspzsbsiK/ojJBFnJNRXnR7W0
         ZveRLlLXNxxf23fYD2JKbIU80UCV55GzvQMgdezI=
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com, wedsonaf@google.com
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Maninder Singh <maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>

kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
writes on index "KSYM_NAME_LEN - 1".

Thus array size should be KSYM_NAME_LEN.

for hexagon it was defined as "128" directly.
and commit '61968dbc2d5d' changed define value to 512,
So both were missed to update with new size.

Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..65b30b6ea226 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -82,7 +82,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	const char *name = NULL;
 	unsigned long *newfp;
 	unsigned long low, high;
-	char tmpstr[128];
+	char tmpstr[KSYM_NAME_LEN];
 	char *modname;
 	int i;
 
-- 
2.17.1

