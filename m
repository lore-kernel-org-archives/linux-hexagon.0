From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
Date: Thu, 22 Jul 2021 22:07:30 +0200
Message-ID: <YPnQAksI2+YBivHb@osiris>
References: <20210722124814.778059-1-arnd@kernel.org>
 <20210722124814.778059-10-arnd@kernel.org>
 <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
 <CAK8P3a0xZAHknG8_kc62aaKrKdzD-QwQYHT61_wTbFDYADu-zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/IIwgmWLf/L22dTWKUTFLUR5Q6z6o+dw/JacSF+Et5I=; b=V3ODypXKXhPnSV
	6DMApe58ieudv2QJYDNUclRKMVFWFE5rwosU6FvvI20mzwPGlksAEEBRcQLHoUmQkZDzlHD9XpH5o
	IppzAgpHDzi93BlEnOq+5OQxkJs6TEfiVGL/McSJoJ1n9lF0ZUyPombs9ZrAvN6T6znxwU9Ngzx1g
	mMc62vkTyOutf8DmI5jFZ1nBnTFzO/geK5xjWZixvtuJgpNdSDX4InOwrv+O22GEWsnCvdLrLF6Qp
	fLez8BvAYx0SP3oqS32Y50L5GHb+zachlG4ayJT/ocCLi3VxC9vKItITF3jSCXjQZMQgaBTK9oW6g
	rmoN+53Uq2UuTzUKwTdA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=pxAZategEXP9Z9IUmmXjkgKFL8QhCxHo+LvV20yfc2o=;
 b=fjjJhSDax+UCFsdpimc9E3TVazmtoFisK7o63Z+aHnuQ10h7P4+U6pvjKZwoioVpTMHE
 3prsevvG27k8JeTXrgUpGjNwXCkR3ltK2BKT6W5/ln2pRbAdWSYnPsjTgH8K+KGJTsbv
 Y/ptFbQEjeTvs6oOFWslY/BLY8YsxBBnnydeqd4O+hPIxB+2LG28ogaJaQoH5F/GbdQX
 UucM8ZgGNnfKCKOOxhZqN5WD9tnFwX//42CGw1akKWTaVkDOJBWpUVYIgF9jarMzLcrI
 2uVAsnYSDggZtLauY4Udme6XGd76gkt46EvqDithPRcBoF5qOEpryZ18nDPM1W7SQlW8 tQ== 
Content-Disposition: inline
In-Reply-To: <CAK8P3a0xZAHknG8_kc62aaKrKdzD-QwQYHT61_wTbFDYADu-zw@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+glud-user-mode-linux-devel=m.gmane-mx.org@lists.infradead.org
To: Arnd Bergmann <arnd@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Cain <bcain@codeaurora.org>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-csky@vger.kernel.org, "open list:QUALCOMM HEXAGON..." <linux-he>

On Thu, Jul 22, 2021 at 04:01:39PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 22, 2021 at 3:57 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> >
> > >
> > > The remaining architectures at the moment are: ia64, mips, parisc,
> > > s390, um and xtensa. We should probably convert these as well, but
> >
> > I'm not sure it makes sense to convert um, the implementation uses
> > strncpy(), and that should use the libc implementation, which is tuned
> > for the actual hardware that the binary is running on, so performance
> > wise that might be better.
> >
> > OTOH, maybe this is all in the noise given the huge syscall overhead in
> > um, so maybe unifying it would make more sense.
> 
> Right, makes sense. I suppose if we end up converting mips and s390,
> we should just do arch/um and the others as well for consistency, even
> if that adds some overhead.

Feel free to add the s390 patch below on top of your series. However
one question: the strncpy_from_user() prototype now comes everywhere
without the __must_check attribute. Is there any reason for that?

At least for s390 I want to keep that.

From 03ad679909af58e1dc6864f47ce67210f0534c39 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 22 Jul 2021 21:48:18 +0200
Subject: [PATCH] s390: use generic strncpy/strnlen from_user

The s390 variant of strncpy_from_user() is slightly faster than the
generic variant, however convert to the generic variant now to follow
most if not all other architectures.

Converting to the generic variant was already considered a couple of
years ago. See commit f5c8b9601036 ("s390/uaccess: use sane length for
__strncpy_from_user()").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig               |  2 --
 arch/s390/include/asm/uaccess.h | 18 ++----------
 arch/s390/lib/uaccess.c         | 52 ---------------------------------
 3 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index f4f39087cad0..a0e2130f0100 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -75,8 +75,6 @@ config S390
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
-	select ARCH_HAS_STRNCPY_FROM_USER
-	select ARCH_HAS_STRNLEN_USER
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 2316f2440881..9ed9aa37e836 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -233,23 +233,9 @@ raw_copy_in_user(void __user *to, const void __user *from, unsigned long n);
 /*
  * Copy a null terminated string from userspace.
  */
+long __must_check strncpy_from_user(char *dst, const char __user *src, long count);
 
-long __strncpy_from_user(char *dst, const char __user *src, long count);
-
-static inline long __must_check
-strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	might_fault();
-	return __strncpy_from_user(dst, src, count);
-}
-
-unsigned long __must_check __strnlen_user(const char __user *src, unsigned long count);
-
-static inline unsigned long strnlen_user(const char __user *src, unsigned long n)
-{
-	might_fault();
-	return __strnlen_user(src, n);
-}
+long __must_check strnlen_user(const char __user *src, long count);
 
 /*
  * Zero Userspace
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index 7ec8b1fa0f08..94ca99bde59d 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -338,55 +338,3 @@ unsigned long __clear_user(void __user *to, unsigned long size)
 	return clear_user_xc(to, size);
 }
 EXPORT_SYMBOL(__clear_user);
-
-static inline unsigned long strnlen_user_srst(const char __user *src,
-					      unsigned long size)
-{
-	unsigned long tmp1, tmp2;
-
-	asm volatile(
-		"   lghi  0,0\n"
-		"   la    %2,0(%1)\n"
-		"   la    %3,0(%0,%1)\n"
-		"   slgr  %0,%0\n"
-		"   sacf  256\n"
-		"0: srst  %3,%2\n"
-		"   jo    0b\n"
-		"   la    %0,1(%3)\n"	/* strnlen_user results includes \0 */
-		"   slgr  %0,%1\n"
-		"1: sacf  768\n"
-		EX_TABLE(0b,1b)
-		: "+a" (size), "+a" (src), "=a" (tmp1), "=a" (tmp2)
-		:
-		: "cc", "memory", "0");
-	return size;
-}
-
-unsigned long __strnlen_user(const char __user *src, unsigned long size)
-{
-	if (unlikely(!size))
-		return 0;
-	return strnlen_user_srst(src, size);
-}
-EXPORT_SYMBOL(__strnlen_user);
-
-long __strncpy_from_user(char *dst, const char __user *src, long size)
-{
-	size_t done, len, offset, len_str;
-
-	if (unlikely(size <= 0))
-		return 0;
-	done = 0;
-	do {
-		offset = (size_t)src & (L1_CACHE_BYTES - 1);
-		len = min(size - done, L1_CACHE_BYTES - offset);
-		if (copy_from_user(dst, src, len))
-			return -EFAULT;
-		len_str = strnlen(dst, len);
-		done += len_str;
-		src += len_str;
-		dst += len_str;
-	} while ((len_str == len) && (done < size));
-	return done;
-}
-EXPORT_SYMBOL(__strncpy_from_user);
-- 
2.25.1
