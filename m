From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 5/5] kallsyms: remove unsed API lookup_symbol_attrs
Date: Fri, 20 May 2022 14:07:01 +0530
Message-ID: <20220520083701.2610975-6-maninder1.s@samsung.com>
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083805epcas5p40642f5a7f9844c61792cd3ac41ac01d3@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220520083916epoutp023cb1a42d725b95d6d8f1594f01295d96~ww3GiYS5L1883218832epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035956;
        bh=UsfrS4UvuS4dFM05SqF8Ta7tbBY/QrlkptYTWqQNH+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aia/QyHkPpm/zR9tj4Cj7Hno19svunmYHyHwsInquziQDKY6IlXghgdpNSmRLJkwO
         rMMgMNRRTwdODovo4wXmgmRKS2FfG2tsdIrmOBUT4Rusv/VF9vkaCQC3zAi4lJgly2
         CJZrPhtTbfKzpzk8glBclSgx019w9KpRKn0+ZccE=
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com, mcgrof@kernel.org, jason.wessel@windriver.com, daniel.thompson@linaro.org, dianders@chromium.org, naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, rostedt@goodmis.org, senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, akpm@linux-foundation.org, arnd@arndb.de
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-modules@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com, onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>

with commit '7878c231dae0 ("slab: remove /proc/slab_allocators")'
lookup_symbol_attrs usage is removed.

Thus removing redundant API.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/kallsyms.h |  6 ------
 include/linux/module.h   |  6 ------
 kernel/kallsyms.c        | 28 ----------------------------
 kernel/module/kallsyms.c | 28 ----------------------------
 4 files changed, 68 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 8fe535fd848a..b78e9d942a77 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -91,7 +91,6 @@ extern int sprint_backtrace(char *buffer, size_t size, unsigned long address);
 extern int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname, size_t size);
-int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 /* How and when do we show kallsyms values? */
 extern bool kallsyms_show_value(const struct cred *cred);
@@ -153,11 +152,6 @@ static inline int lookup_symbol_name(unsigned long addr, char *symname, size_t s
 	return -ERANGE;
 }
 
-static inline int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name)
-{
-	return -ERANGE;
-}
-
 static inline bool kallsyms_show_value(const struct cred *cred)
 {
 	return false;
diff --git a/include/linux/module.h b/include/linux/module.h
index 9b91209d615f..4c5f8f99a252 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -658,7 +658,6 @@ const char *module_address_lookup(unsigned long addr,
 			    char **modname, const unsigned char **modbuildid,
 			    char *namebuf, size_t buf_size);
 int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size);
-int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 int register_module_notifier(struct notifier_block *nb);
 int unregister_module_notifier(struct notifier_block *nb);
@@ -766,11 +765,6 @@ static inline int lookup_module_symbol_name(unsigned long addr, char *symname, s
 	return -ERANGE;
 }
 
-static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name)
-{
-	return -ERANGE;
-}
-
 static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
 					char *type, char *name,
 					char *module_name, int *exported)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index d6efce28505d..96ad59b5b2fd 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -430,34 +430,6 @@ int lookup_symbol_name(unsigned long addr, char *symname, size_t size)
 	return 0;
 }
 
-int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
-			unsigned long *offset, char *modname, char *name)
-{
-	int res;
-
-	name[0] = '\0';
-	name[KSYM_NAME_LEN - 1] = '\0';
-
-	if (is_ksym_addr(addr)) {
-		unsigned long pos;
-
-		pos = get_symbol_pos(addr, size, offset);
-		/* Grab name */
-		kallsyms_expand_symbol(get_symbol_offset(pos),
-				       name, KSYM_NAME_LEN);
-		modname[0] = '\0';
-		goto found;
-	}
-	/* See if it's in a module. */
-	res = lookup_module_symbol_attrs(addr, size, offset, modname, name);
-	if (res)
-		return res;
-
-found:
-	cleanup_symbol_name(name);
-	return 0;
-}
-
 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, size_t buf_size, unsigned long address,
 			   int symbol_offset, int add_offset, int add_buildid)
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index c982860405c6..e6f16c62a888 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -375,34 +375,6 @@ int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size)
 	return -ERANGE;
 }
 
-int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
-			       unsigned long *offset, char *modname, char *name)
-{
-	struct module *mod;
-
-	preempt_disable();
-	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-		if (within_module(addr, mod)) {
-			const char *sym;
-
-			sym = find_kallsyms_symbol(mod, addr, size, offset);
-			if (!sym)
-				goto out;
-			if (modname)
-				strscpy(modname, mod->name, MODULE_NAME_LEN);
-			if (name)
-				strscpy(name, sym, KSYM_NAME_LEN);
-			preempt_enable();
-			return 0;
-		}
-	}
-out:
-	preempt_enable();
-	return -ERANGE;
-}
-
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *name, char *module_name, int *exported)
 {
-- 
2.17.1

