From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 10/30] memblock: replace __alloc_bootmem_node_nopanic with
 memblock_alloc_try_nid_nopanic
Date: Fri, 14 Sep 2018 15:10:25 +0300
Message-ID: <1536927045-23536-11-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RsE0OTxKjsrn6+AGf//0bvaNf+2IshTCiBuXwfKvN64=; b=kj4BRfuhNnDqHGw4IUvd+QxDCA
	si85oPh8gT+Z9GXM9hNuNlcQnDgdfK7zq7a9b3+0Tb5NQ1617gZLuV8DrLDRLEue/j1hh/e/iyzwz
	Bi+2zJApl/MRsGbOMYDtVSemp7bxFioBrJ8CzYgao+76ahibL4dsT0FIHbkdecW4M0sy66j7xWokd
	y1vaO2ugaTK/Y8E8WEw82Yk+cnncAAaq2sOcVUQqJyf1a/IzkU4RTx3w5btA+lJSdSi8pdOddCPHg
	ZZqeLarBvfuaL3Yq9bB/NC1KNJ6BQ5vXwO+J2KJhtHAm+vEPQDI6nRtGGZpNa7ns5OP6Ifo1GPSXY
	nYzTniow==;
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
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
To: linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Russell King <linux@armlinux.org.uk>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-alpha@vge

The __alloc_bootmem_node_nopanic() attempts to allocate memory for a
specified node. If the allocation fails it then retries to allocate memory
from any node. Upon success, the allocated memory is set to 0.

The memblock_alloc_try_nid_nopanic() does exactly the same thing and can be
used instead.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/x86/kernel/setup_percpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index ea554f8..67d48e26 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -112,8 +112,10 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
 			 cpu, size, __pa(ptr));
 	} else {
-		ptr = __alloc_bootmem_node_nopanic(NODE_DATA(node),
-						   size, align, goal);
+		ptr = memblock_alloc_try_nid_nopanic(size, align, goal,
+						     BOOTMEM_ALLOC_ACCESSIBLE,
+						     node);
+
 		pr_debug("per cpu data for cpu%d %lu bytes on node%d at %016lx\n",
 			 cpu, size, node, __pa(ptr));
 	}
-- 
2.7.4
