From: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Sat, 20 Aug 2022 01:23:41 +0000
Message-ID: <SN6PR02MB4205F782AC9A36E5CC5EBB0CB86F9@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=28zxGg6Ec1jP/EGHMi+1N7+b7cVLBdqKokb5G0Vo6qc=;
 b=MbeYkUOLVKttQeCos32djRdjz9nF2G4vzrtx6kOQEbV8Kq1V7rRPwL4zu+bYLMbarwn1
 jynE/2N89yPfluIGR0tnji9Pgbvn6TUWpq5Gv+ak2SB0ChcfMxuuYQ9m9tYXJgbLNbeC
 6yaOjFNpuBV9KO5r44ZVuzuzdzK8866gGCmOMC+EIrACDOyLHQmN6zQtKFHTM/WRkVbs
 2g22sWg+ZV75RgDp8Y2heZoHh8dq/DA3bVEJ8vOUSxmuMEKTtZRrS3BGsYktOC7bWWF1
 Uj5Qzi1aDr8aOWGcFzIgsM0wp3XFEDIxoY3HGJ9QPFHdBSayAe35ZWMz9nZ55ydUGQMC pg== 
In-Reply-To: <20220820003125.353570-6-bhe@redhat.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Baoquan He <bhe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hch@infradead.org" <hch@infradead.org>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>

> -----Original Message-----
> From: Baoquan He <bhe@redhat.com>
...
> With it, the old ioremap() and iounmap() can be perfectly removed
> since they are duplicated with the standard functions.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org
> ---

Acked-by: Brian Cain <bcain@quicinc.com>
