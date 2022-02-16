From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 14/18] lib/test_lockup: fix kernel pointer check for
 separate address spaces
Date: Wed, 16 Feb 2022 14:13:28 +0100
Message-ID: <20220216131332.1489939-15-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5JrwkZZCRtbw8Bh1EEeOMQpcvVWSTDmy6nfhAQLcAvQ=; b=lj+wkwFs8ldF5x
	u2rdqQj8KYTdN2jNXf2Qlq24pWlGXkIlVDR7gnTeUEJkA6XSFXPas0NDoRw/14l1Ju4RBwIj0ER2b
	1T+axOgifO0a+LjDhG1FukzabGlEN1p+MoS0wQnK8Y+bNK+66wBCKo48JniYzEQaRxzA/DKyS1lys
	OWU6RBbjO5HJNkDEBzbb4JaUvszMzt03tCHluRwXu0FjFvNk5K6DE6/V52a4ev6Zguh62YPhJZHlJ
	OTCEDMTEaNzHO8TYNzK5iVd9MNj6vKgBIsTogs/FCspI4BK+qtJcewJ44+FF1pwwss2v036Byj40+
	1T6rOpLk9pggGFy+j/lQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645017484;
 bh=VX4KkQyuIR3tQGDR6prM8ou6pbxkhf/vAdqGON90Cm0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CHCgfRQJGdosNV1evKFnaA5ei4xJAQnutJJPhJDJedQb8ubdZ/7Y4gbjZfBoHlpfu
 02zUcTsVmwftwP3VFFw8cf1xplYfxud05Hq90fcOl+6pChvWJp2VuJGg6f1dhDmeKP
 2Ku7d6y9bCG/B7QQIkLEQll/VqhOb3oxvRxpjL7bHiIP7fh7rr3NkfNXH+hMaXbIfa
 qHFBF3xOTCoSqLhRyub3LajzF4xQe4lV+XRk2zeVmUEYrZWjONVkWPfTimkvr5qUGC
 VogArIAmhrmBKTIWZOEA4fZwuT8tCTP8ztaTT853tTOy2yqxBDNJ8/RxehDqdkvFhY
 Yb158iS57sWQQ==
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc: linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.k

From: Arnd Bergmann <arnd@arndb.de>

test_kernel_ptr() uses access_ok() to figure out if a given address
points to user space instead of kernel space. However on architectures
that set CONFIG_ALTERNATE_USER_ADDRESS_SPACE, a pointer can be valid
for both, and the check always fails because access_ok() returns true.

Make the check for user space pointers conditional on the type of
address space layout.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_lockup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 6a0f329a794a..c3fd87d6c2dd 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -417,9 +417,14 @@ static bool test_kernel_ptr(unsigned long addr, int size)
 		return false;
 
 	/* should be at least readable kernel address */
-	if (access_ok((void __user *)ptr, 1) ||
-	    access_ok((void __user *)ptr + size - 1, 1) ||
-	    get_kernel_nofault(buf, ptr) ||
+	if (!IS_ENABLED(CONFIG_ALTERNATE_USER_ADDRESS_SPACE) &&
+	    (access_ok((void __user *)ptr, 1) ||
+	     access_ok((void __user *)ptr + size - 1, 1))) {
+		pr_err("user space ptr invalid in kernel: %#lx\n", addr);
+		return true;
+	}
+
+	if (get_kernel_nofault(buf, ptr) ||
 	    get_kernel_nofault(buf, ptr + size - 1)) {
 		pr_err("invalid kernel ptr: %#lx\n", addr);
 		return true;
-- 
2.29.2
