From: Christoph Hellwig <hch@lst.de>
Subject: generic ioremap (and lots of cleanups) v3
Date: Tue, 29 Oct 2019 07:48:13 +0100
Message-ID: <20191029064834.23438-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=elJdm5YEkgaxfMIoGZYM6bRzeo6ZlpcC7gIeT5PBANg=; b=fxr8vXm4oU3fWt
	C3yyDJ77Xbgtx0JTQtgvyLGz7LaZ+429+NfPESfWFrlK2v3tBuqboVpLoVlseVEIJago0twir/SO5
	npxHMkMMBN8yoSxk+ZVbnbMkV87Zc5rDXeDgbBPfrSAFbmSTU10/C43sdVtplc0086cudGXC0mS/G
	Opogf7PgXRgZtHCACHQwqMx4iTJMfAA0opDnOTstJ0o65NGYG11t+40O2pshmgzVC/60xq5lPnnMz
	lGgby1xh1GSaKfzHEdLBjw7cmCOadoM4xbZl1d9uM0ZTq1WbizyEy3Y+jPivD4IInkeaTH04x3rmu
	d9xpGQAfV2AkmIrLPzkQ==;
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
To: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-mtd@lists.infradead.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi all,

the last patches in this series add a generic ioremap implementation,
and switch our 3 most recent and thus most tidy architeture ports over
to use it.  With a little work and an additional arch hook or two the
implementation should be able to eventually cover more than half of
our ports.

The patches before that clean up various lose ends in the ioremap
and iounmap implementations.

Note that there is no good tree this would fit, which means I'd set up
a tree to it to Linus unless someone has a better idea.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git generic-ioremap

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap

Changes since v2:
 - fix various typos
 - move the m68k __free_io_area around instead of introducing a forward
   declaration

Changes since v1:
 - dropped various patches already merged
 - keep the parts of the parisc EISA hack that are still needed
