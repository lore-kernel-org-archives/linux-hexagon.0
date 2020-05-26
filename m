From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 08/20] arm64: simplify detection of memory zone
 boundaries for UMA configs
Date: Tue, 26 May 2020 18:15:17 +0100
Message-ID: <20200526171516.GL17051@gaia>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-9-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TEFcgTzuSTgQuZYzihrMJQ6zuwKF+X81TKHZq6eTqgU=; b=qa839SuJLpMS8b
	ZcTPGgMTW/UVDgSnXYcuitCbMWNW7HcI5tbvsPsmLDQ9CSXlUrp/Rusc3gEyHJc9e1STyVFWgPtE4
	oMN5aKy6bmo+FoKyMVpk49Ddzm16SzdcLyi9gb2X46pq2NjpaaNcieLlqtAv5BLNHjsAeW4Cc4XaE
	wNngeO9a+rGVUghqARxLA7VP3GCHANFCh62Hc0+Q/79HpdrqXFoSCNtBJEXEj34KZltK0siRkcY6N
	CC4NbgJAj9QmPAmZLVR3UEcRmnm0/ubrCMa+nlrDTjPDY5NPsQdljafvdrlqEhORmJfH3hAwH52PL
	Do9macXbAt/JdlXkQYdQ==;
Content-Disposition: inline
In-Reply-To: <20200429121126.17989-9-rppt@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.co>

On Wed, Apr 29, 2020 at 03:11:14PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The free_area_init() function only requires the definition of maximal PFN
> for each of the supported zone rater than calculation of actual zone sizes
> and the sizes of the holes between the zones.
> 
> After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
> available to all architectures.
> 
> Using this function instead of free_area_init_node() simplifies the zone
> detection.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(BTW, none of my acks so far made it to the linux-arm-kernel list
because of the large number of people on cc)
