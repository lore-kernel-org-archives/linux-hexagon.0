From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: add support for the global coherent pool to the dma core
Date: Mon, 12 Jul 2021 08:16:57 +0200
Message-ID: <20210712061704.4162464-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=tB53rqP9UurlO9Ubjzx5fIdyCBO9p4biSEwOPXSsFqo=; b=dzMdOtVbZVRxxudw8++DeGPLtl
 rWxB7mGdvYuZ4AETWUbLfJHkL5g99xedhkEC8KrVXGsmNoSlWEJYkmw27IQ2HCHwgxqPeyGuF6n4z
 QV9wDQYnD8Xvq+2OvZbS9BxxcfMtaMQm31nocFhIQsHL5sNTFpkFdq0RGPmo9w8EKt5Sgyqz2YJDp
 Jmzgs5iBpf32uKiThPw9SABqwTDqjLZ3uoaQgfcF9XbmQu1cTVLTe2CGbZLHz2/AmYKVGEylaRWKo
 T3qxVMUSY97ijE+OPbZ1AVZZwp8QbsOyfdmqGMkxYq8pjsTM7FWsjS9/wwxeczXm49LAbQbsFgFOu
 2WwsE6Uw==;
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Brian Cain <bcain-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, Dillon Min <dillon.minfei-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Hi all,

this series adds support for using the global coherent (aka uncached)
pool to the generic dma-direct code and then switches arm-nommu and
hexagon over to it, together with a bunch of cleanups.

Diffstat:
 arch/arm/Kconfig                |    5 -
 arch/arm/mm/dma-mapping-nommu.c |  173 +---------------------------------------
 arch/hexagon/Kconfig            |    1 
 arch/hexagon/kernel/dma.c       |   57 ++-----------
 include/linux/dma-map-ops.h     |   18 ++--
 kernel/dma/Kconfig              |    4 
 kernel/dma/coherent.c           |  159 +++++++++++++++++-------------------
 kernel/dma/direct.c             |   15 +++
 8 files changed, 124 insertions(+), 308 deletions(-)
