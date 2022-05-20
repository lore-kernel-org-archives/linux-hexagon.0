From: Maninder Singh <maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/5] arch:hexagon/powerpc: use KSYM_NAME_LEN as array size
Date: Fri, 20 May 2022 14:06:59 +0530
Message-ID: <20220520083701.2610975-4-maninder1.s@samsung.com>
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083742epcas5p4fa741caf7079a1305ef99cf00a07054a@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220520083908epoutp04e5d832cdb53a09d97a5302b58812c15f~ww2-NMO6u0301803018epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035948;
        bh=AhwgzerEVuyodIt2V4RrrdlfDM0bzVilGZy8x4sycs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rB9mGpJKv/QU7ikLSrehieGW0N7+ipKkLWILLN4Zb0gO5zeQhvV3Lsj2fREzYqJK3
         prI85zw5E82ahobCBB0BJAYfUdGfxlsOELX73Lsa+Ne51+tE707SQOVtbKtJQrj3pi
         5SV4iFkm9nG1zthB/ni2KOBTr9exXbsxtV0zAu7c=
In-Reply-To: <20220520083701.2610975-1-maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, pmladek-IBi9RG/b67k@public.gmane.org, bcain-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, hca-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, gor-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, agordeev-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, borntraeger-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, svens-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, satishkh-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, sebaddel-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, kartilak-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason.wessel-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, naveen.n.rao-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, boqun.feng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, senozhatsky-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-modules-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kgdb-bugreport-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, v.narang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, onkarnath.1-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Maninder Singh <maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
writes on index "KSYM_NAME_LEN - 1".

Thus array size should be KSYM_NAME_LEN.

for powerpc and hexagon it was defined as "128" directly.
and commit '61968dbc2d5d' changed define value to 512,
So both were missed to update with new size.

Fixes: 61968dbc2d5d("kallsyms: increase maximum kernel symbol length to 512")
Signed-off-by: Maninder Singh <maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/hexagon/kernel/traps.c | 2 +-
 arch/powerpc/xmon/xmon.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index afc827c65ff2..3441fc70ac92 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -91,7 +91,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];
-- 
2.17.1

