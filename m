From: Maninder Singh <maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/5] kallsyms: pass buffer size argument in *lookup* APIs
Date: Fri, 20 May 2022 14:07:00 +0530
Message-ID: <20220520083701.2610975-5-maninder1.s@samsung.com>
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083755epcas5p454d450935fb427fd270295e967b0cbe8@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220520083912epoutp04475d86947c29a6a873fdc8406b40b7e1~ww3C0Uw8c0301803018epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035952;
        bh=DWp8DOllJXXACHeuxZYMqjT1Q6GxgVAt1nlrOcuuYKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqyOA/9F/aqly1EbRo/oFIoK5BewuquEYc8yevnVyWmIy4ccuH79VM09FPBLBPWvv
         G6FDEkjOuWZ7lM0zHsWizBeUsLzdtuOoCwqI0i8QOiNP+CQ8tV3ISWpFd5+LvDglJL
         8tFpQfttPl2SFb3NDSCYJF4qkDQJvuc95FAVkpsU=
In-Reply-To: <20220520083701.2610975-1-maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, pmladek-IBi9RG/b67k@public.gmane.org, bcain-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, hca-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, gor-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, agordeev-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, borntraeger-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, svens-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, satishkh-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, sebaddel-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, kartilak-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason.wessel-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, naveen.n.rao-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, boqun.feng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, senozhatsky-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-modules-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kgdb-bugreport-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, v.narang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, onkarnath.1-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Maninder Singh <maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Although *lookup* APIs are safe, but better to pass size
as an argument rather than using define KSYM_NAME_LEN.
Because it can cause issue if called with lesser array size.

Co-developed-by: Onkarnath <onkarnath.1-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Onkarnath <onkarnath.1-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Maninder Singh <maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/hexagon/kernel/traps.c        |  2 +-
 arch/powerpc/xmon/xmon.c           |  4 ++--
 fs/proc/base.c                     |  2 +-
 include/linux/kallsyms.h           |  8 ++++----
 include/linux/module.h             |  8 ++++----
 kernel/debug/kdb/kdb_support.c     |  2 +-
 kernel/kallsyms.c                  | 24 ++++++++++++------------
 kernel/kprobes.c                   |  4 ++--
 kernel/locking/lockdep.c           |  8 ++++----
 kernel/locking/lockdep_internals.h |  2 +-
 kernel/locking/lockdep_proc.c      |  4 ++--
 kernel/module/kallsyms.c           |  8 ++++----
 kernel/trace/ftrace.c              |  9 +++++----
 kernel/trace/trace_kprobe.c        |  2 +-
 kernel/trace/trace_output.c        |  2 +-
 kernel/trace/trace_syscalls.c      |  2 +-
 16 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 65b30b6ea226..a0306e96e82c 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -118,7 +118,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 
 	for (i = 0; i < kstack_depth_to_print; i++) {
 
-		name = kallsyms_lookup(ip, &size, &offset, &modname, tmpstr);
+		name = kallsyms_lookup(ip, &size, &offset, &modname, tmpstr, KSYM_NAME_LEN);
 
 		printk("%s[%p] 0x%lx: %s + 0x%lx", loglvl, fp, ip, name, offset);
 		if (((unsigned long) fp < low) || (high < (unsigned long) fp))
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3441fc70ac92..183e2a55ba5c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1710,7 +1710,7 @@ static void get_function_bounds(unsigned long pc, unsigned long *startp,
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
-		name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
+		name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr, KSYM_NAME_LEN);
 		if (name != NULL) {
 			*startp = pc - offset;
 			*endp = pc - offset + size;
@@ -3730,7 +3730,7 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 		catch_memory_errors = 1;
 		sync();
 		name = kallsyms_lookup(address, &size, &offset, &modname,
-				       tmpstr);
+				       tmpstr, KSYM_NAME_LEN);
 		sync();
 		/* wait a little while to see if we get a machine check */
 		__delay(200);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617816168748..939006f3b2b0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -392,7 +392,7 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 		goto print0;
 
 	wchan = get_wchan(task);
-	if (wchan && !lookup_symbol_name(wchan, symname)) {
+	if (wchan && !lookup_symbol_name(wchan, symname, KSYM_NAME_LEN)) {
 		seq_puts(m, symname);
 		return 0;
 	}
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 598ff08c72d6..8fe535fd848a 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -81,7 +81,7 @@ extern int kallsyms_lookup_size_offset(unsigned long addr,
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname, char *namebuf);
+			    char **modname, char *namebuf, size_t size);
 
 /* Look up a kernel symbol and return it in a text buffer. */
 extern int sprint_symbol(char *buffer, size_t size, unsigned long address);
@@ -90,7 +90,7 @@ extern int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long addr
 extern int sprint_backtrace(char *buffer, size_t size, unsigned long address);
 extern int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address);
 
-int lookup_symbol_name(unsigned long addr, char *symname);
+int lookup_symbol_name(unsigned long addr, char *symname, size_t size);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 /* How and when do we show kallsyms values? */
@@ -113,7 +113,7 @@ static inline int kallsyms_lookup_size_offset(unsigned long addr,
 static inline const char *kallsyms_lookup(unsigned long addr,
 					  unsigned long *symbolsize,
 					  unsigned long *offset,
-					  char **modname, char *namebuf)
+					  char **modname, char *namebuf, size_t size)
 {
 	return NULL;
 }
@@ -148,7 +148,7 @@ static inline int sprint_backtrace_build_id(char *buffer, size_t size, unsigned
 	return 0;
 }
 
-static inline int lookup_symbol_name(unsigned long addr, char *symname)
+static inline int lookup_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	return -ERANGE;
 }
diff --git a/include/linux/module.h b/include/linux/module.h
index abd9fa916b7d..9b91209d615f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -656,8 +656,8 @@ const char *module_address_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
 			    char **modname, const unsigned char **modbuildid,
-			    char *namebuf);
-int lookup_module_symbol_name(unsigned long addr, char *symname);
+			    char *namebuf, size_t buf_size);
+int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size);
 int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 int register_module_notifier(struct notifier_block *nb);
@@ -756,12 +756,12 @@ static inline const char *module_address_lookup(unsigned long addr,
 					  unsigned long *offset,
 					  char **modname,
 					  const unsigned char **modbuildid,
-					  char *namebuf)
+					  char *namebuf, size_t buf_size)
 {
 	return NULL;
 }
 
-static inline int lookup_module_symbol_name(unsigned long addr, char *symname)
+static inline int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	return -ERANGE;
 }
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 0a39497140bf..bf19e9587c23 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -92,7 +92,7 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 		goto out;
 
 	symtab->sym_name = kallsyms_lookup(addr, &symbolsize , &offset,
-				(char **)(&symtab->mod_name), namebuf);
+				(char **)(&symtab->mod_name), namebuf, KSYM_NAME_LEN);
 	if (offset > 8*1024*1024) {
 		symtab->sym_name = NULL;
 		addr = offset = symbolsize = 0;
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 9e4316fe0ba1..d6efce28505d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -342,18 +342,18 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 		get_symbol_pos(addr, symbolsize, offset);
 		return 1;
 	}
-	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
+	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf, KSYM_NAME_LEN) ||
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
 static const char *kallsyms_lookup_buildid(unsigned long addr,
 			unsigned long *symbolsize,
 			unsigned long *offset, char **modname,
-			const unsigned char **modbuildid, char *namebuf)
+			const unsigned char **modbuildid, char *namebuf, size_t size)
 {
 	const char *ret;
 
-	namebuf[KSYM_NAME_LEN - 1] = 0;
+	namebuf[size - 1] = 0;
 	namebuf[0] = 0;
 
 	if (is_ksym_addr(addr)) {
@@ -362,7 +362,7 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 		pos = get_symbol_pos(addr, symbolsize, offset);
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
-				       namebuf, KSYM_NAME_LEN);
+				       namebuf, size);
 		if (modname)
 			*modname = NULL;
 		if (modbuildid)
@@ -374,7 +374,7 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 
 	/* See if it's in a module or a BPF JITed image. */
 	ret = module_address_lookup(addr, symbolsize, offset,
-				    modname, modbuildid, namebuf);
+				    modname, modbuildid, namebuf, size);
 	if (!ret)
 		ret = bpf_address_lookup(addr, symbolsize,
 					 offset, modname, namebuf);
@@ -398,18 +398,18 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname, char *namebuf)
+			    char **modname, char *namebuf, size_t size)
 {
 	return kallsyms_lookup_buildid(addr, symbolsize, offset, modname,
-				       NULL, namebuf);
+				       NULL, namebuf, size);
 }
 
-int lookup_symbol_name(unsigned long addr, char *symname)
+int lookup_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	int res;
 
 	symname[0] = '\0';
-	symname[KSYM_NAME_LEN - 1] = '\0';
+	symname[size - 1] = '\0';
 
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
@@ -417,11 +417,11 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 		pos = get_symbol_pos(addr, NULL, NULL);
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
-				       symname, KSYM_NAME_LEN);
+				       symname, size);
 		goto found;
 	}
 	/* See if it's in a module. */
-	res = lookup_module_symbol_name(addr, symname);
+	res = lookup_module_symbol_name(addr, symname, size);
 	if (res)
 		return res;
 
@@ -470,7 +470,7 @@ static int __sprint_symbol(char *buffer, size_t buf_size, unsigned long address,
 
 	address += symbol_offset;
 	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
-				       buffer);
+				       buffer, buf_size);
 	if (!name)
 		return scnprintf(buffer, buf_size, "0x%lx", address - symbol_offset);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd58c0be9ce2..3b362b70e72b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1478,7 +1478,7 @@ bool within_kprobe_blacklist(unsigned long addr)
 		return true;
 
 	/* Check if the address is on a suffixed-symbol */
-	if (!lookup_symbol_name(addr, symname)) {
+	if (!lookup_symbol_name(addr, symname, KSYM_NAME_LEN)) {
 		p = strchr(symname, '.');
 		if (!p)
 			return false;
@@ -2806,7 +2806,7 @@ static int show_kprobe_addr(struct seq_file *pi, void *v)
 	preempt_disable();
 	hlist_for_each_entry_rcu(p, head, hlist) {
 		sym = kallsyms_lookup((unsigned long)p->addr, NULL,
-					&offset, &modname, namebuf);
+					&offset, &modname, namebuf, KSYM_NAME_LEN);
 		if (kprobe_aggrprobe(p)) {
 			list_for_each_entry_rcu(kp, &p->list, list)
 				report_probe(pi, kp, sym, offset, modname, p);
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 81e87280513e..c74bbf90fdfb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -659,9 +659,9 @@ static const char *usage_str[] =
 };
 #endif
 
-const char *__get_key_name(const struct lockdep_subclass_key *key, char *str)
+const char *__get_key_name(const struct lockdep_subclass_key *key, char *str, size_t size)
 {
-	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
+	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str, size);
 }
 
 static inline unsigned long lock_flag(enum lock_usage_bit bit)
@@ -715,7 +715,7 @@ static void __print_lock_name(struct lock_class *class)
 
 	name = class->name;
 	if (!name) {
-		name = __get_key_name(class->key, str);
+		name = __get_key_name(class->key, str, KSYM_NAME_LEN);
 		printk(KERN_CONT "%s", name);
 	} else {
 		printk(KERN_CONT "%s", name);
@@ -746,7 +746,7 @@ static void print_lockdep_cache(struct lockdep_map *lock)
 
 	name = lock->name;
 	if (!name)
-		name = __get_key_name(lock->key->subkeys, str);
+		name = __get_key_name(lock->key->subkeys, str, KSYM_NAME_LEN);
 
 	printk(KERN_CONT "%s", name);
 }
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000260d0..ab32ee6a0c87 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -129,7 +129,7 @@ extern void get_usage_chars(struct lock_class *class,
 			    char usage[LOCK_USAGE_CHARS]);
 
 extern const char *__get_key_name(const struct lockdep_subclass_key *key,
-				  char *str);
+				  char *str, size_t size);
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 15fdc7fa5c68..bf4ca5ec109e 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -63,7 +63,7 @@ static void print_name(struct seq_file *m, struct lock_class *class)
 	const char *name = class->name;
 
 	if (!name) {
-		name = __get_key_name(class->key, str);
+		name = __get_key_name(class->key, str, KSYM_NAME_LEN);
 		seq_printf(m, "%s", name);
 	} else{
 		seq_printf(m, "%s", name);
@@ -485,7 +485,7 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 		char str[KSYM_NAME_LEN];
 		const char *key_name;
 
-		key_name = __get_key_name(ckey, str);
+		key_name = __get_key_name(ckey, str, KSYM_NAME_LEN);
 		snprintf(name, namelen, "%s", key_name);
 	} else {
 		snprintf(name, namelen, "%s", cname);
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..c982860405c6 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -320,7 +320,7 @@ const char *module_address_lookup(unsigned long addr,
 			    unsigned long *offset,
 			    char **modname,
 			    const unsigned char **modbuildid,
-			    char *namebuf)
+			    char *namebuf, size_t buf_size)
 {
 	const char *ret = NULL;
 	struct module *mod;
@@ -342,7 +342,7 @@ const char *module_address_lookup(unsigned long addr,
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
-		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
+		strncpy(namebuf, ret, buf_size - 1);
 		ret = namebuf;
 	}
 	preempt_enable();
@@ -350,7 +350,7 @@ const char *module_address_lookup(unsigned long addr,
 	return ret;
 }
 
-int lookup_module_symbol_name(unsigned long addr, char *symname)
+int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	struct module *mod;
 
@@ -365,7 +365,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 			if (!sym)
 				goto out;
 
-			strscpy(symname, sym, KSYM_NAME_LEN);
+			strscpy(symname, sym, size);
 			preempt_enable();
 			return 0;
 		}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c12bcd26cb17..4d9a8621eaac 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -520,7 +520,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 		goto out;
 #endif
 
-	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str, KSYM_SYMBOL_LEN);
 	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -3980,7 +3980,7 @@ ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 	char str[KSYM_SYMBOL_LEN];
 	char *modname;
 
-	kallsyms_lookup(rec->ip, NULL, NULL, &modname, str);
+	kallsyms_lookup(rec->ip, NULL, NULL, &modname, str, KSYM_SYMBOL_LEN);
 
 	if (mod_g) {
 		int mod_matches = (modname) ? ftrace_match(modname, mod_g) : 0;
@@ -4738,7 +4738,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 
 			if (func_g.search) {
 				kallsyms_lookup(entry->ip, NULL, NULL,
-						NULL, str);
+						NULL, str, KSYM_SYMBOL_LEN);
 				if (!ftrace_match(str, &func_g))
 					continue;
 			}
@@ -6846,7 +6846,8 @@ static void save_ftrace_mod_rec(struct ftrace_mod_map *mod_map,
 	char *modname;
 	const char *ret;
 
-	ret = kallsyms_lookup(rec->ip, &symsize, &offset, &modname, str);
+	ret = kallsyms_lookup(rec->ip, &symsize, &offset, &modname,
+				str, KSYM_SYMBOL_LEN);
 	if (!ret)
 		return;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47cebef78532..8a1d2a0dc2dc 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -456,7 +456,7 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 		return false;
 
 	/* Check if the address is on a suffixed-symbol */
-	if (!lookup_symbol_name(addr, symname)) {
+	if (!lookup_symbol_name(addr, symname, KSYM_NAME_LEN)) {
 		p = strchr(symname, '.');
 		if (!p)
 			return true;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 2a6ec049cab5..0d3e1c9b59fb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -364,7 +364,7 @@ trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 	if (offset)
 		sprint_symbol(str, KSYM_SYMBOL_LEN, address);
 	else
-		kallsyms_lookup(address, NULL, NULL, NULL, str);
+		kallsyms_lookup(address, NULL, NULL, NULL, str, KSYM_SYMBOL_LEN);
 	name = kretprobed(str, address);
 
 	if (name && strlen(name)) {
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f755bde42fd0..3a67877ce658 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -89,7 +89,7 @@ find_syscall_meta(unsigned long syscall)
 
 	start = __start_syscalls_metadata;
 	stop = __stop_syscalls_metadata;
-	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
+	kallsyms_lookup(syscall, NULL, NULL, NULL, str, KSYM_SYMBOL_LEN);
 
 	if (arch_syscall_match_sym_name(str, "sys_ni_syscall"))
 		return NULL;
-- 
2.17.1

