From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
Date: Wed, 25 Apr 2018 23:07:57 +0200
Message-ID: <84d9e1ac-86c3-6f2e-377f-2be44783b933@gmx.de>
References: <20180420080313.18796-1-hch@lst.de>
 <20180420080313.18796-23-hch@lst.de>
 <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de> <20180425072105.GA12308@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U6rUcsWRua80aW+xpiVyPDNjvXwbchojUvkwkPKPnZk=; b=nxZl3zqHkihfbk
	pcV1l6bJtZvk7H3e2EjtveTRUdoHIumQuORN5YRLcJk4v79lyGBVWrTvTY6V7U7AJFxbajf7fInH/
	7Hh+I8ekStgxBRK6B8VKmklCCQT1zP5+9Sna0V96yyLhQo1MkAXG/IeILVYjin/JmplPeFa4Rz2pJ
	adraGe47PLZBX8MsWn2ST/9qVH781kzJ/fY5PpkSVhwyNJEQiAODqttd6ZAAq3O0wZAppk1d4fDjq
	5aS0wLnyzYYPkMgq5R/mz8l0e20mYEVDiIEFQqbT7lM2Fj34s5psQlKRgG/C9h7jkb1VOf+z1tntq
	dd24gaHHZZ54jm23YN9g==;
In-Reply-To: <20180425072105.GA12308@lst.de>
Content-Language: en-US
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
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 25.04.2018 09:21, Christoph Hellwig wrote:
> On Sat, Apr 21, 2018 at 07:43:46PM +0200, Helge Deller wrote:
>> This patch breaks a 32bit kernel on a B160L machine (PA7300LC CPU, "pcxl2").
>> After applying this patch series the lasi82956 network driver works unreliable. 
>> NIC gets IP, but ping doesn't work.
>> See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.
> 
> Just to confirm:  Without the series it is known to actually work?

Yes.
I reverted this series from my tree, rebuilt, and then the issue was gone.
I won't be able to test again earlier than next week.

Helge
