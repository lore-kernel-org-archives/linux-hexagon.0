From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH v2 08/18] uaccess: add generic
 __{get,put}_kernel_nofault
Date: Fri, 18 Feb 2022 07:30:19 +0100
Message-ID: <20220218063019.GF22576@lst.de>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-9-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20220216131332.1489939-9-arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcain-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org, nickhu-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, hca-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Looks good:

Reviewed-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
