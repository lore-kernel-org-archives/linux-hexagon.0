From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 0/5] kallsyms: make kallsym APIs more safe with scnprintf
Date: Fri, 20 May 2022 14:06:56 +0530
Message-ID: <20220520083701.2610975-1-maninder1.s@samsung.com>
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220520083855epoutp016fa069d66602b42f61964cb062d9f8d5~ww2zHyyO_2633026330epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035935;
        bh=oZhGlLI83t5qJYIpB4tYvwEL1hnzUFffSLhokei+vZw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ipd4KLW4NM9s1EshcHiVYcOCkwPMINX24v6Ff8vxhss0aRvGT3BAM+Z2tgxqYcKw0
         qNjaNJkTm0uxpL6ti92DZ17Gaf4U+g4fYaLnhavWvPgve8gXKSklZoHPvBd1TT+SfT
         rBmVRrBfDNF483ylhq7Vc+97bXV0LRsjU1ieKMag=
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com, mcgrof@kernel.org, jason.wessel@windriver.com, daniel.thompson@linaro.org, dianders@chromium.org, naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, rostedt@goodmis.org, senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, akpm@linux-foundation.org, arnd@arndb.de
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-modules@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com, onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>

kallsyms functionality depends on KSYM_NAME_LEN directly.
but if user passed array length lesser than it, sprintf
can cause issues of buffer overflow attack.

So changing *sprint* and *lookup* APIs in this patch set
to have buffer size as an argument and replacing sprintf with
scnprintf.

patch 1 and 2 can be clubbed, but then it will be difficult
to review, so patch 1 changes prototype only and patch 2
includes passed argument usage.

Patch 3 and patch 5 are bug fixes.
Patch 1, 2 and 4 are changing prorotypes.

Tried build and kallsyms test on ARM64 environment.
APIs are called at multiple places. So build can
be failed if updation missed at any place.
lets see if autobot reports any build failure
with any config combination.

[   12.247313] ps function_check [crash]
[   12.247906] pS function_check+0x4/0x40 [crash]
[   12.247999] pSb function_check+0x4/0x40 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.248092] pB function_check+0x4/0x40 [crash]
[   12.248190] pBb function_check+0x4/0x40 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
...
[   12.261175] Call trace:
[   12.261361]  function_2+0x74/0x88 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.261859]  function_1+0x10/0x1c [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.262237]  hello_init+0x24/0x34 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.262603]  do_one_initcall+0x54/0x1c8
[   12.262803]  do_init_module+0x44/0x1d0
[   12.262992]  load_module+0x1688/0x19f0
[   12.263179]  __do_sys_init_module+0x1a0/0x210
[   12.263387]  __arm64_sys_init_module+0x1c/0x28
[   12.263596]  invoke_syscall+0x44/0x108
[   12.263788]  el0_svc_common.constprop.0+0x44/0xf0
[   12.264014]  do_el0_svc_compat+0x1c/0x50
[   12.264209]  el0_svc_compat+0x2c/0x88
[   12.264397]  el0t_32_sync_handler+0x90/0x140
[   12.264600]  el0t_32_sync+0x190/0x194


Maninder Singh, Onkarnath (5):
  kallsyms: pass buffer size in sprint_* APIs
  kallsyms: replace sprintf with scprintf
  arch:hexagon/powerpc: use KSYM_NAME_LEN as array size
  kallsyms: pass buffer size argument in *lookup* APIs
  kallsyms: remove unsed API lookup_symbol_attrs

 arch/hexagon/kernel/traps.c        |  4 +-
 arch/powerpc/xmon/xmon.c           |  6 +-
 arch/s390/lib/test_unwind.c        |  2 +-
 drivers/scsi/fnic/fnic_trace.c     |  8 +--
 fs/proc/base.c                     |  2 +-
 include/linux/kallsyms.h           | 34 +++++------
 include/linux/module.h             | 14 ++---
 init/main.c                        |  2 +-
 kernel/debug/kdb/kdb_support.c     |  2 +-
 kernel/kallsyms.c                  | 92 ++++++++++++------------------
 kernel/kprobes.c                   |  4 +-
 kernel/locking/lockdep.c           |  8 +--
 kernel/locking/lockdep_internals.h |  2 +-
 kernel/locking/lockdep_proc.c      |  4 +-
 kernel/module/kallsyms.c           | 36 ++----------
 kernel/trace/ftrace.c              |  9 +--
 kernel/trace/trace_kprobe.c        |  2 +-
 kernel/trace/trace_output.c        |  4 +-
 kernel/trace/trace_syscalls.c      |  2 +-
 lib/vsprintf.c                     | 10 ++--
 20 files changed, 93 insertions(+), 154 deletions(-)

-- 
2.17.1

