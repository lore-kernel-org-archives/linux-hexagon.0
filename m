From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 14/21] xtensa: simplify detection of memory zone boundaries
Date: Sun, 12 Apr 2020 22:48:52 +0300
Message-ID: <20200412194859.12663-15-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZK9dMRgitvacCQIOam1+2b5RBsgqMvBauP5QYkZ8hdw=; b=NY29j1LZXT5Q4R
	ueiQoQF54pmdjFYXQjIdiPCFJVVDurrm7VtQDZlpshctmpFR8dilu6u8YP9kZ/vrQX5RF21b2ZpZu
	Y6YkFOLNzqn4ZVcPC2mfqVG0++V593+n1rMuLo6J2qd+VkwOhpCuu9LGwcDkGCjtSh/IsCVBvYYPR
	KQjxiQ4XnQr9p0NmC04yJQ4RnNUcdYDDN/ewE7t0xtpLS9PNKT8JnvlL2J2+6RjGLsvR60FA8Ko43
	DHgNBZco7qM87Rl1JqPiyEdcaSYE35ZtNY17DKjqH8tq/Wmb/rWgve4NBZZgkEKfnZfJYI2l+Qlv5
	cS0BsVWlvT2MiBlJDZFw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586721165;
 bh=kg4dZKJ579N986CAoZmLROmIpOcRvYn6L1WsJDxOIl8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M03jHDXjV3O72ZpMby0hutf5uyRC1PKMh5Up9F7+dMgi3d5b/SM0V7rzcP3iMzTI8
 3JkXkIjXkrlZSXxjUt9xlmS4iLXB2oSwrPflLocjX5KHIdgMKTiTQivjIGtjXdJ36v
 mKibE3Tjm6gd7jGsV4TErO9jVxTXOdHVgsjyb7xw=
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@in>

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() function only requires the definition of maximal PFN
for each of the supported zone rater than calculation of actual zone sizes
and the sizes of the holes between the zones.

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
available to all architectures.

Using this function instead of free_area_init_node() simplifies the zone
detection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/xtensa/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 19c625e6d81f..a05b306cf371 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -70,13 +70,13 @@ void __init bootmem_init(void)
 void __init zones_init(void)
 {
 	/* All pages are DMA-able, so we put them all in the DMA zone. */
-	unsigned long zones_size[MAX_NR_ZONES] = {
-		[ZONE_NORMAL] = max_low_pfn - ARCH_PFN_OFFSET,
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = {
+		[ZONE_NORMAL] = max_low_pfn,
 #ifdef CONFIG_HIGHMEM
-		[ZONE_HIGHMEM] = max_pfn - max_low_pfn,
+		[ZONE_HIGHMEM] = max_pfn,
 #endif
 	};
-	free_area_init_node(0, zones_size, ARCH_PFN_OFFSET, NULL);
+	free_area_init(max_zone_pfn);
 }
 
 #ifdef CONFIG_HIGHMEM
-- 
2.25.1


