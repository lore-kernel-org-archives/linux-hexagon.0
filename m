From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 11/30] memblock: replace alloc_bootmem_pages_nopanic with
 memblock_alloc_nopanic
Date: Fri, 14 Sep 2018 15:10:26 +0300
Message-ID: <1536927045-23536-12-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Yk4ch6IJm/eE5ge9Ni7p1KsgvyKJvmHGy9I4Th3HVt0=; b=WtxRsPaIIxD5yT45R11LywONsG
	v46KebSyuS5SSiB2SBanMwwk24t2sk/nTNt+IIXduqvkgZb5k6JMA/SKmacMB8e2VWVoPQD2msoSY
	6JN9/rIJ5REuUxGwcy7kWlTJMJQ5AqrzhfIX82T4bM+78Ic2e2YuPASUC8rGfb5Pk6Yvuav6u+S1M
	2o2D1YGRxyzB13q254y6C3v7/Nfav+miDgZV9Kh6jMdv66zoAlNbQelVbfNIIoywyJq26l9+Wt+52
	r500vG/Mg8quSLBbguwl6SASAFyYzqPgFl2JL7xytRjlroXFFKfV0ESih2nId+LuIuGuKIjgMmOUA
	HonEmERw==;
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Russell King <linux@armlinux.org.uk>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-alpha@vge

The alloc_bootmem_pages_nopanic(size) is a shortcut for
__alloc_bootmem_nopanic(size, PAGE_SIZE, BOOTMEM_LOW_LIMIT) which allocates
PAGE_SIZE aligned memory. Since BOOTMEM_LOW_LIMIT is hardwired to 0 there
is no restrictions on where the allocated memory should reside.

The memblock_alloc_nopanic(size, PAGE_SIZE) also allocates PAGE_SIZE
aligned memory without any restrictions and thus can be used as a
replacement for alloc_bootmem_pages_nopanic()

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 drivers/usb/early/xhci-dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index e15e896..16df968 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -94,7 +94,7 @@ static void * __init xdbc_get_page(dma_addr_t *dma_addr)
 {
 	void *virt;
 
-	virt = alloc_bootmem_pages_nopanic(PAGE_SIZE);
+	virt = memblock_alloc_nopanic(PAGE_SIZE, PAGE_SIZE);
 	if (!virt)
 		return NULL;
 
-- 
2.7.4
