From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH 07/21] parisc: remove __ioremap
Date: Thu, 17 Oct 2019 23:35:42 +0200
Message-ID: <1650819.dOKmve5HLd@daneel.sf-tec.de>
References: <20191017174554.29840-1-hch@lst.de>
 <20191017174554.29840-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3558820823259705002=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gipKRgFaUPQ8AOpduES+pcooXX+6VlJnY8d8wM3Oye0=; b=b1RJSY5bgyxZWe/ObyAyIiCw/
	8k1Vf59lsYSfK51fJRZDtrj+c1FIgzsXJzK/O/+VUM0FKAg5r5a2DHYCyoo8QIo+s/wKzrXNtnlNL
	ekXER/0ZgApDRfxBWYdDTMGFxgQ8JGCnBP99yTE/KfxG4q+5YvQUW9/rUOUTLQeY6G/tHRh8mwkVw
	4m5QEgkrZPHSRdFkOZYKA0XblJHUzABd1yx/GJsJ+9/9QL/LtgCnnTex2SVOJG/Hf3NGppB7BXEDC
	/Vjdu7ShSWA6zkwW7OFuZJpYzDFcNvCBvzShgGzjEpjH4qTBW9rN28ebLOQmF15MabpFjZUbKX57J
	GfIUIbJHg==;
In-Reply-To: <20191017174554.29840-8-hch@lst.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-mtd@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org

--===============3558820823259705002==
Content-Type: multipart/signed; boundary="nextPart3002460.JnYtLPdinj"; micalg="pgp-sha1"; protocol="application/pgp-signature"

--nextPart3002460.JnYtLPdinj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Christoph Hellwig wrote:
> __ioremap is always called with the _PAGE_NO_CACHE, so fold the whole
> thing and rename it to ioremap.  This allows allows to remove the
                                        ^^^^^^^^^^^^^
> special EISA quirk to force _PAGE_NO_CACHE.

Eike
--nextPart3002460.JnYtLPdinj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCXajergAKCRBcpIk+abn8
TkOlAJ46117xxLoFzZCiYYebEyVSrw/31gCeMRBoULeYp+iYijM534mn8tCGYHM=
=d3J8
-----END PGP SIGNATURE-----

--nextPart3002460.JnYtLPdinj--





--===============3558820823259705002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============3558820823259705002==--




