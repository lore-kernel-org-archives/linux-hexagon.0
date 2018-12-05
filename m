From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] arch: remove redundant generic-y defines
Date: Wed,  5 Dec 2018 20:28:06 +0900
Message-ID: <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KjggBL+yBa3Yjf8VSJGf5ZR8iA5BFYaOE2CzMZGwA3w=; b=rR+ynrgx2G7elQ6O8Z0RYvkWUx
	tzB+e5upsyTW8pJtQqgxiuj2yIdlFZDwWXUlK2vP0ySkGprJym8VfWHBs+Yf0OYEg1hx00T3vfDm1
	LvrFubxeI0gAx9mypxzu2ReSvmbDGoqTy9bWnyOt3+wmjXjThVw+bj8cLL6sm/Urj1At+BC7jqJBH
	HmbCo9YdWwdnYq82bEH3328c1tCHAkn+TTD+celrBd437Rx1e+X6Q/r3isLCOtUnyaPYiz2rKudiL
	BP52m77y2TCkYVXHHf1HzWFdSwDyJn9chQpeKCwnqsOpkPghruTp1rnr24V8JYftxhR9A1zDcHCj+
	GhxAu9nQ==;
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB5BSBlX028064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544009297;
 bh=xrb0PNo5pw/YPjt31K6EqFjYwJsZcMHyXIulbXaDXq8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gA9OqMQeKbZz4K3aUZbxGPRafiVZ7f+fi9LF6c0zMWmQUWZ0+9LC/t4HkagPLAddC
 Kp6zfCNRAhf6KwSvvJecBgIGya47w6yxGE+yYWyGghD8/v+X+rymb8HBLWmM0eDLD2
 6FnDuVbsB7sqVuNJsL9KZHX6zg3d4gIZgUeqUP97ElFxELr8GEDyfy056JlCyHCbG2
 NRGFxob3tzmOB9Epk71KfdQk0GuXKCUwLWlc6LTWlVXO70TC2xllCpmQ0gcvzbqMie
 87fh9te2CSWgtxpsgCqtinq882SjKF/63O6CZqxQkkj6UrlFUly7PDVy0Of+PeWgP6
 Wr0R51bhN1tXw==
In-Reply-To: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, James Hogan <jhogan@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Daniel Borkmann <daniel@iogearbox.net>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-alpha@vger.kernel.org, I

Now that Kbuild automatically creates asm-generic wrappers for missing
mandatory headers, it is redundant to list the same headers in
generic-y and mandatory-y.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/alpha/include/uapi/asm/Kbuild      |  5 -----
 arch/arc/include/uapi/asm/Kbuild        | 23 -----------------------
 arch/arm/include/uapi/asm/Kbuild        | 15 ---------------
 arch/arm64/include/uapi/asm/Kbuild      | 17 -----------------
 arch/c6x/include/uapi/asm/Kbuild        | 25 -------------------------
 arch/h8300/include/uapi/asm/Kbuild      | 25 -------------------------
 arch/hexagon/include/uapi/asm/Kbuild    | 22 ----------------------
 arch/ia64/include/uapi/asm/Kbuild       |  5 -----
 arch/m68k/include/uapi/asm/Kbuild       | 18 ------------------
 arch/microblaze/include/uapi/asm/Kbuild | 24 ------------------------
 arch/mips/include/uapi/asm/Kbuild       |  1 -
 arch/nds32/include/uapi/asm/Kbuild      | 24 ------------------------
 arch/nios2/include/uapi/asm/Kbuild      | 24 ------------------------
 arch/openrisc/include/uapi/asm/Kbuild   | 26 --------------------------
 arch/parisc/include/uapi/asm/Kbuild     |  5 -----
 arch/powerpc/include/uapi/asm/Kbuild    |  6 ------
 arch/riscv/include/uapi/asm/Kbuild      | 25 -------------------------
 arch/s390/include/uapi/asm/Kbuild       | 14 --------------
 arch/sh/include/uapi/asm/Kbuild         | 17 -----------------
 arch/sparc/include/uapi/asm/Kbuild      |  1 -
 arch/unicore32/include/uapi/asm/Kbuild  | 27 ---------------------------
 arch/x86/include/uapi/asm/Kbuild        |  1 -
 arch/xtensa/include/uapi/asm/Kbuild     |  8 --------
 23 files changed, 358 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 1a5b753..14a2e9a 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -2,8 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 170b5db..f53f8e4 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,29 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 4d1cc18..279edb1 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -6,19 +6,4 @@ generated-y += unistd-common.h
 generated-y += unistd-oabi.h
 generated-y += unistd-eabi.h
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += termbits.h
-generic-y += termios.h
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 6c5adf4..bca548a 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -2,21 +2,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
-generic-y += siginfo.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 26644e1..f53f8e4 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,31 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 2f65f78..f53f8e4 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,31 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index 41a176d..c0488dc 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,27 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 3982e67..f5c6967 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -2,9 +2,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index c2e26a4..f5c6967 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,23 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 2c6a6bf..f53f8e4 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,30 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index 7a4becd..14a2e9a 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
index 40be972..c0488dc 100644
--- a/arch/nds32/include/uapi/asm/Kbuild
+++ b/arch/nds32/include/uapi/asm/Kbuild
@@ -2,28 +2,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += shmbuf.h
-generic-y += bitsperlong.h
-generic-y += fcntl.h
-generic-y += stat.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 13a3d77..f53f8e4 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,30 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 130c16c..f53f8e4 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,32 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index adb5c64..f5c6967 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,10 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
 generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += siginfo.h
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index a658091..14a2e9a 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -2,9 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += siginfo.h
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index 5511b99..14a2e9a 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -1,29 +1,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += setup.h
-generic-y += unistd.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
-generic-y += siginfo.h
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index dc38a90..3e1b12d 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -5,17 +5,3 @@ include include/uapi/asm-generic/Kbuild.asm
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += siginfo.h
\ No newline at end of file
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index ba4d39c..f53f8e4 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,23 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += ucontext.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index 4680ba2..14a2e9a 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += types.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 8611ef9..f53f8e4 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,33 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 3226816..1e901e4 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -5,4 +5,3 @@ generic-y += bpf_perf_event.h
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
-generic-y += poll.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 837d4dd..f5c6967 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,13 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
 generic-y += kvm_para.h
-generic-y += resource.h
-generic-y += siginfo.h
-generic-y += statfs.h
-generic-y += termios.h
-- 
2.7.4
