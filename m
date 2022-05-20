From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/5] kallsyms: pass buffer size in sprint_* APIs
Date: Fri, 20 May 2022 14:06:57 +0530
Message-ID: <20220520083701.2610975-2-maninder1.s@samsung.com>
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083725epcas5p1c3e2989c991e50603a40c81ccc4982e0@epcas5p1.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220520083858epoutp01f63876db122f22a254f3048e34e755eb~ww22eq2bc2582325823epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035938;
        bh=tGQbcADDC9Fa03PFlfhjPFDOHvT6aH+E1Jkc3ryxF7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsu5EaV+kpXXRtq0bfaZOYjgr0vXVUkPsQah8PfwSdBSUlscRsrKfxiOlZlTcz7Tv
         CwUHypFtFHa9ibH3iF4X64NQKQWCL6SyK/HY5lChVqIgO1OdJpnxbO7Ky/Lsy5MKQb
         9q6CTX8IXnAQO8jwstpIeAldIC7fTvS1kmwIy4JE=
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com, mcgrof@kernel.org, jason.wessel@windriver.com, daniel.thompson@linaro.org, dianders@chromium.org, naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, rostedt@goodmis.org, senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, akpm@linux-foundation.org, arnd@arndb.de
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-modules@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com, onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>

As of now sprint_* APIs don't pass buffer size as an argument
and use sprintf directly.

To replace dangerous sprintf API to scnprintf,
buffer size is required in arguments.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/s390/lib/test_unwind.c    |  2 +-
 drivers/scsi/fnic/fnic_trace.c |  8 ++++----
 include/linux/kallsyms.h       | 20 ++++++++++----------
 init/main.c                    |  2 +-
 kernel/kallsyms.c              | 27 ++++++++++++++++-----------
 kernel/trace/trace_output.c    |  2 +-
 lib/vsprintf.c                 | 10 +++++-----
 7 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 5a053b393d5c..adbc2b53db16 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -75,7 +75,7 @@ static noinline int test_unwind(struct task_struct *task, struct pt_regs *regs,
 			ret = -EINVAL;
 			break;
 		}
-		sprint_symbol(sym, addr);
+		sprint_symbol(sym, KSYM_SYMBOL_LEN, addr);
 		if (bt_pos < BT_BUF_SIZE) {
 			bt_pos += snprintf(bt + bt_pos, BT_BUF_SIZE - bt_pos,
 					   state.reliable ? " [%-7s%px] %pSR\n" :
diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index 4a7536bb0ab3..33acaa9bb4ba 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -128,10 +128,10 @@ int fnic_get_trace_data(fnic_dbgfs_t *fnic_dbgfs_prt)
 			}
 			/* Convert function pointer to function name */
 			if (sizeof(unsigned long) < 8) {
-				sprint_symbol(str, tbp->fnaddr.low);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.low);
 				jiffies_to_timespec64(tbp->timestamp.low, &val);
 			} else {
-				sprint_symbol(str, tbp->fnaddr.val);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.val);
 				jiffies_to_timespec64(tbp->timestamp.val, &val);
 			}
 			/*
@@ -170,10 +170,10 @@ int fnic_get_trace_data(fnic_dbgfs_t *fnic_dbgfs_prt)
 			}
 			/* Convert function pointer to function name */
 			if (sizeof(unsigned long) < 8) {
-				sprint_symbol(str, tbp->fnaddr.low);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.low);
 				jiffies_to_timespec64(tbp->timestamp.low, &val);
 			} else {
-				sprint_symbol(str, tbp->fnaddr.val);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.val);
 				jiffies_to_timespec64(tbp->timestamp.val, &val);
 			}
 			/*
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 649faac31ddb..598ff08c72d6 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -84,11 +84,11 @@ const char *kallsyms_lookup(unsigned long addr,
 			    char **modname, char *namebuf);
 
 /* Look up a kernel symbol and return it in a text buffer. */
-extern int sprint_symbol(char *buffer, unsigned long address);
-extern int sprint_symbol_build_id(char *buffer, unsigned long address);
-extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
-extern int sprint_backtrace(char *buffer, unsigned long address);
-extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
+extern int sprint_symbol(char *buffer, size_t size, unsigned long address);
+extern int sprint_symbol_build_id(char *buffer, size_t size, unsigned long address);
+extern int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long address);
+extern int sprint_backtrace(char *buffer, size_t size, unsigned long address);
+extern int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
@@ -118,31 +118,31 @@ static inline const char *kallsyms_lookup(unsigned long addr,
 	return NULL;
 }
 
-static inline int sprint_symbol(char *buffer, unsigned long addr)
+static inline int sprint_symbol(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_symbol_build_id(char *buffer, unsigned long address)
+static inline int sprint_symbol_build_id(char *buffer, size_t size, unsigned long address)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_symbol_no_offset(char *buffer, unsigned long addr)
+static inline int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_backtrace(char *buffer, unsigned long addr)
+static inline int sprint_backtrace(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_backtrace_build_id(char *buffer, unsigned long addr)
+static inline int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
diff --git a/init/main.c b/init/main.c
index 40255f110885..399a15857bf9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1207,7 +1207,7 @@ static bool __init_or_module initcall_blacklisted(initcall_t fn)
 		return false;
 
 	addr = (unsigned long) dereference_function_descriptor(fn);
-	sprint_symbol_no_offset(fn_name, addr);
+	sprint_symbol_no_offset(fn_name, KSYM_SYMBOL_LEN, addr);
 
 	/*
 	 * fn will be "function_name [module_name]" where [module_name] is not
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 87e2b1638115..f354378e241f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -459,7 +459,7 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 }
 
 /* Look up a kernel symbol and return it in a text buffer. */
-static int __sprint_symbol(char *buffer, unsigned long address,
+static int __sprint_symbol(char *buffer, size_t buf_size, unsigned long address,
 			   int symbol_offset, int add_offset, int add_buildid)
 {
 	char *modname;
@@ -502,6 +502,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 /**
  * sprint_symbol - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function looks up a kernel symbol with @address and stores its name,
@@ -510,15 +511,16 @@ static int __sprint_symbol(char *buffer, unsigned long address,
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_symbol(char *buffer, unsigned long address)
+int sprint_symbol(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 0);
+	return __sprint_symbol(buffer, size, address, 0, 1, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol);
 
 /**
  * sprint_symbol_build_id - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function looks up a kernel symbol with @address and stores its name,
@@ -527,15 +529,16 @@ EXPORT_SYMBOL_GPL(sprint_symbol);
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_symbol_build_id(char *buffer, unsigned long address)
+int sprint_symbol_build_id(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 1);
+	return __sprint_symbol(buffer, size, address, 0, 1, 1);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
 
 /**
  * sprint_symbol_no_offset - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function looks up a kernel symbol with @address and stores its name
@@ -544,15 +547,16 @@ EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_symbol_no_offset(char *buffer, unsigned long address)
+int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 0, 0);
+	return __sprint_symbol(buffer, size, address, 0, 0, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
 
 /**
  * sprint_backtrace - Look up a backtrace symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function is for stack backtrace and does the same thing as
@@ -564,14 +568,15 @@ EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_backtrace(char *buffer, unsigned long address)
+int sprint_backtrace(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 0);
+	return __sprint_symbol(buffer, size, address, -1, 1, 0);
 }
 
 /**
  * sprint_backtrace_build_id - Look up a backtrace symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function is for stack backtrace and does the same thing as
@@ -584,9 +589,9 @@ int sprint_backtrace(char *buffer, unsigned long address)
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_backtrace_build_id(char *buffer, unsigned long address)
+int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 1);
+	return __sprint_symbol(buffer, size, address, -1, 1, 1);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 8aa493d25c73..2a6ec049cab5 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -362,7 +362,7 @@ trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 	const char *name;
 
 	if (offset)
-		sprint_symbol(str, address);
+		sprint_symbol(str, KSYM_SYMBOL_LEN, address);
 	else
 		kallsyms_lookup(address, NULL, NULL, NULL, str);
 	name = kretprobed(str, address);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f8ff861ef24a..cb241b63c967 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -991,15 +991,15 @@ char *symbol_string(char *buf, char *end, void *ptr,
 
 #ifdef CONFIG_KALLSYMS
 	if (*fmt == 'B' && fmt[1] == 'b')
-		sprint_backtrace_build_id(sym, value);
+		sprint_backtrace_build_id(sym, KSYM_SYMBOL_LEN, value);
 	else if (*fmt == 'B')
-		sprint_backtrace(sym, value);
+		sprint_backtrace(sym, KSYM_SYMBOL_LEN, value);
 	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
-		sprint_symbol_build_id(sym, value);
+		sprint_symbol_build_id(sym, KSYM_SYMBOL_LEN, value);
 	else if (*fmt != 's')
-		sprint_symbol(sym, value);
+		sprint_symbol(sym, KSYM_SYMBOL_LEN, value);
 	else
-		sprint_symbol_no_offset(sym, value);
+		sprint_symbol_no_offset(sym, KSYM_SYMBOL_LEN, value);
 
 	return string_nocheck(buf, end, sym, spec);
 #else
-- 
2.17.1

