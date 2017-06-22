From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: new dma-mapping tree, was Re: clean up and modularize arch
	dma_mapping interface V2
Date: Fri, 23 Jun 2017 07:53:09 +1000
Message-ID: <20170623075309.1e679168@canb.auug.org.au>
References: <20170616181059.19206-1-hch@lst.de> <20170620124140.GA27163@lst.de>
	<20170620230400.1a5ae889@canb.auug.org.au>
	<CGME20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365@epcas1p4.samsung.com>
	<20170620131623.GB30769@lst.de>
	<5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
	s=201702; t=1498168390;
	bh=ywXrzY6bUrluSNE/4Wv2oLZ9q/yfzIcJiVfp+kW3Bm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2q1nx3zGvlp4s3hl4RWhsuaNhYeX31vFbRXw6OKYj2ZN3QQbrt6t/Ia2EqJupiTO
	Utfw2kM6UlkFT1KXUS8E7ZWJwo1qAJXpLyDrA2VeFDXmRGf68mBhIANbLRO9/wQ3yk
	zClY5fQILPDASsPz0cj5eq7zRxPOvyxFcWYVbrs+CVWcru9VOrAR3wRqqD9/JcztRD
	/h/2octFNxg1tv0b6c+fM+giJ+nswmuvtMeI4dzkD+zlcPbZXreoTQwJSiVw9cYU6l
	3qf7domfYqdqP5P2p3cLgGAlgPJkxW9zAmq20eAzQmE8Qza6HSJUvpC1fvM9m+rdNW
	MnzL5eFfA25lw==
In-Reply-To: <5425587c-73e8-e24a-86a3-8a65a7791dcb-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Hi all,

On Wed, 21 Jun 2017 15:32:39 +0200 Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>
> On 2017-06-20 15:16, Christoph Hellwig wrote:
> > On Tue, Jun 20, 2017 at 11:04:00PM +1000, Stephen Rothwell wrote:  
> >> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next
> >>
> >> Contacts: Marek Szyprowski and Kyungmin Park (cc'd)
> >>
> >> I have called your tree dma-mapping-hch for now.  The other tree has
> >> not been updated since 4.9-rc1 and I am not sure how general it is.
> >> Marek, Kyungmin, any comments?  
> > I'd be happy to join efforts - co-maintainers and reviers are always
> > welcome.  
> 
> I did some dma-mapping unification works in the past and my tree in 
> linux-next
> was a side effect of that. I think that for now it can be dropped in 
> favor of
> Christoph's tree. I can also do some review and help in maintainers work if
> needed, although I was recently busy with other stuff.

OK, so I have dropped the dma-mapping tree and renamed dma-mapping-hch
to dma-mapping.

-- 
Cheers,
Stephen Rothwell
