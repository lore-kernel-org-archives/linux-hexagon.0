From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] arch: unexport asm/shmparam.h for all architectures
Date: Tue,  8 Jan 2019 08:38:27 +0900
Message-ID: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=pXijSFKoQC7C1PqOF/7NhgkPd/48Re1gp3vDBSYhuks=; b=cSW
	anQgVjrQSHYWONIQthR+U4TZ472pGiy4/tggd2MTk4IazCeKjhlMNDGcYdnguY2+hDlRWnabOM7qT
	cGOJZJgmK5lEsafiPGX6wmCfRF5arRAINTJaULE2UwunQLmvpOzD7JE9AipS2ULm4iGOOAsnmyD0I
	vCIz1AIabj4rgqD2hq26a8YOSF6Y/n8HX3pq+N5piarHNQAQ4hcXEQ0bA4iLheorPPNCRozonMNKV
	vlVegg+nF6XureKp31bJfWAv9ADOWKJj6kb1W3nyHDZGBjxjfJeZRJkPIQHIIKuTc765c4MCOlAQs
	zAFEns0ZPdA27whCZS2ebeealivMZmg==;
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x07NcoMo005312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546904332;
 bh=/YEFGu+SBlUdtiWVLWe7ax+bI2tOxreGEJ7URmQvSxc=;
 h=From:To:Cc:Subject:Date:From;
 b=mfEN9aPF8tUwL9rIW1L0UOimuU4zIlgLdR9pNYBrzw0omOecnFJrSWdV4PYOMXe+s
 bEP7Rt9EWVB/Kdmr4LWxfzJs0EPFthNyYpKz08g79W+SfGMHDno9FceKmzcyOnJAd3
 lMad5gndv0y+CS0flNONDkUxpzjChmJDAm5GUcBJMmBBPp8iuv6auAJu8EUzkXV4Jj
 7gT7hfIm+Ajzv2uycXtdCKgh1OrVhtfoa4CGkNiQD7L50j6OCkhifktg8YRLSNQOz+
 mJpDhZ/+13J+fKj8FDDbPLH4nFIxMqzxpPrjtCYoXm42BdHr+3HTjRS+pp9d6tAY/6
 jCbStusWX3gZA==
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp, Jonas Bonn <jonas@southpole.se>, Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Michal Simek <monstr@monstr.eu>, linu

Most architectures do not export shmparam.h to user-space.

  $ find arch -name shmparam.h  | sort
  arch/alpha/include/asm/shmparam.h
  arch/arc/include/asm/shmparam.h
  arch/arm64/include/asm/shmparam.h
  arch/arm/include/asm/shmparam.h
  arch/csky/include/asm/shmparam.h
  arch/ia64/include/asm/shmparam.h
  arch/mips/include/asm/shmparam.h
  arch/nds32/include/asm/shmparam.h
  arch/nios2/include/asm/shmparam.h
  arch/parisc/include/asm/shmparam.h
  arch/powerpc/include/asm/shmparam.h
  arch/s390/include/asm/shmparam.h
  arch/sh/include/asm/shmparam.h
  arch/sparc/include/asm/shmparam.h
  arch/x86/include/asm/shmparam.h
  arch/xtensa/include/asm/shmparam.h

Strangely, some users of the asm-generic wrapper export shmparam.h

  $ git grep 'generic-y += shmparam.h'
  arch/c6x/include/uapi/asm/Kbuild:generic-y += shmparam.h
  arch/h8300/include/uapi/asm/Kbuild:generic-y += shmparam.h
  arch/hexagon/include/uapi/asm/Kbuild:generic-y += shmparam.h
  arch/m68k/include/uapi/asm/Kbuild:generic-y += shmparam.h
  arch/microblaze/include/uapi/asm/Kbuild:generic-y += shmparam.h
  arch/openrisc/include/uapi/asm/Kbuild:generic-y += shmparam.h
  arch/riscv/include/asm/Kbuild:generic-y += shmparam.h
  arch/unicore32/include/uapi/asm/Kbuild:generic-y += shmparam.h

The newly added riscv correctly creates the asm-generic wrapper
in the kernel space, but the others (c6x, h8300, hexagon, m68k,
microblaze, openrisc, unicore32) create the one in the uapi directory.

Digging into the git history, now I guess fcc8487d477a ("uapi:
export all headers under uapi directories") was the misconversion.
Prior to that commit, no architecture exported to shmparam.h
As its commit description said, that commit exported shmparam.h
for c6x, h8300, hexagon, m68k, openrisc, unicore32.

83f0124ad81e ("microblaze: remove asm-generic wrapper headers")
accidentally exported shmparam.h for microblaze.

This commit unexports shmparam.h for those architectures.

There is no more reason to export include/uapi/asm-generic/shmparam.h,
so it has been moved to include/asm-generic/shmparam.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/c6x/include/asm/Kbuild               | 1 +
 arch/c6x/include/uapi/asm/Kbuild          | 1 -
 arch/h8300/include/asm/Kbuild             | 1 +
 arch/h8300/include/uapi/asm/Kbuild        | 1 -
 arch/hexagon/include/asm/Kbuild           | 1 +
 arch/hexagon/include/uapi/asm/Kbuild      | 1 -
 arch/m68k/include/asm/Kbuild              | 1 +
 arch/m68k/include/uapi/asm/Kbuild         | 1 -
 arch/microblaze/include/asm/Kbuild        | 1 +
 arch/microblaze/include/uapi/asm/Kbuild   | 1 -
 arch/openrisc/include/asm/Kbuild          | 1 +
 arch/openrisc/include/uapi/asm/Kbuild     | 1 -
 arch/unicore32/include/asm/Kbuild         | 1 +
 arch/unicore32/include/uapi/asm/Kbuild    | 1 -
 include/{uapi => }/asm-generic/shmparam.h | 0
 15 files changed, 7 insertions(+), 7 deletions(-)
 rename include/{uapi => }/asm-generic/shmparam.h (100%)

diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 33a2c94..63b4a17 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -30,6 +30,7 @@ generic-y += pgalloc.h
 generic-y += preempt.h
 generic-y += segment.h
 generic-y += serial.h
+generic-y += shmparam.h
 generic-y += tlbflush.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 6c6f630..0febf1a 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
-generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index cd400d3..961c1dc 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -40,6 +40,7 @@ generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
+generic-y += shmparam.h
 generic-y += sizes.h
 generic-y += spinlock.h
 generic-y += timex.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 6c6f630..0febf1a 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
-generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 47c4da3..b25fd42 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -30,6 +30,7 @@ generic-y += rwsem.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
+generic-y += shmparam.h
 generic-y += sizes.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index 61d955c..c1b06dc 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 9f1dd26..95f8f63 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += mm-arch-hooks.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
+generic-y += shmparam.h
 generic-y += spinlock.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index b8b3525..960bf1e 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
-generic-y += shmparam.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 9c7d1d2..791cc8d5 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -26,6 +26,7 @@ generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += serial.h
+generic-y += shmparam.h
 generic-y += syscalls.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 28823e3..97823ec 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -2,5 +2,4 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
-generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index eb87cd8..1f04844b 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -34,6 +34,7 @@ generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += sections.h
 generic-y += segment.h
+generic-y += shmparam.h
 generic-y += string.h
 generic-y += switch_to.h
 generic-y += topology.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 6c6f630..0febf1a 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
-generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 1372553..1d1544b 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -28,6 +28,7 @@ generic-y += preempt.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
+generic-y += shmparam.h
 generic-y += sizes.h
 generic-y += syscalls.h
 generic-y += topology.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 6c6f630..0febf1a 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
-generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/include/uapi/asm-generic/shmparam.h b/include/asm-generic/shmparam.h
similarity index 100%
rename from include/uapi/asm-generic/shmparam.h
rename to include/asm-generic/shmparam.h
-- 
2.7.4
