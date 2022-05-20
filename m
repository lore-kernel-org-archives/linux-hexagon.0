From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 2/5] kallsyms: replace sprintf with scnprintf
Date: Fri, 20 May 2022 14:06:58 +0530
Message-ID: <20220520083701.2610975-3-maninder1.s@samsung.com>
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083733epcas5p4ff2414309bf128f40b0bbd3adde52297@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220520083904epoutp01d633c5bcdcb6da73271b21c597906494~ww27ZggBF2627726277epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035944;
        bh=2237/Ofuxqe67/VYFRa9P3BISgr2hp9724ybcz8E9F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8EuLCU4damLDZX89+GSfa5zldk34IKUPwDaK6R19ZlesjN7mpBhJsbdnTTWC3qDM
         fObGoLvRtp1uMLJfVvZnPfccUAhB8mogz6NlgreqwZCLKObcXlegTji+lQFr2s3Flw
         pokB64aAUXpFmH+syf18ARawGRcf2nl2fHB5465I=
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com, mcgrof@kernel.org, jason.wessel@windriver.com, daniel.thompson@linaro.org, dianders@chromium.org, naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, rostedt@goodmis.org, senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, akpm@linux-foundation.org, arnd@arndb.de
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-modules@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com, onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>

replace sprintf API with scnprintf which prevents buffer overflow.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 kernel/kallsyms.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index f354378e241f..9e4316fe0ba1 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -472,28 +472,29 @@ static int __sprint_symbol(char *buffer, size_t buf_size, unsigned long address,
 	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
 				       buffer);
 	if (!name)
-		return sprintf(buffer, "0x%lx", address - symbol_offset);
+		return scnprintf(buffer, buf_size, "0x%lx", address - symbol_offset);
 
 	if (name != buffer)
-		strcpy(buffer, name);
+		strncpy(buffer, name, buf_size);
+
 	len = strlen(buffer);
 	offset -= symbol_offset;
 
 	if (add_offset)
-		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
+		len += scnprintf(buffer + len, buf_size - len, "+%#lx/%#lx", offset, size);
 
 	if (modname) {
-		len += sprintf(buffer + len, " [%s", modname);
+		len += scnprintf(buffer + len, buf_size - len, " [%s", modname);
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
 		if (add_buildid && buildid) {
 			/* build ID should match length of sprintf */
 #if IS_ENABLED(CONFIG_MODULES)
 			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
 #endif
-			len += sprintf(buffer + len, " %20phN", buildid);
+			len += scnprintf(buffer + len, buf_size - len, " %20phN", buildid);
 		}
 #endif
-		len += sprintf(buffer + len, "]");
+		len += scnprintf(buffer + len, buf_size - len, "]");
 	}
 
 	return len;
-- 
2.17.1

