From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 02/30] Include generic parity.h in some
 architectures' bitops.h
Date: Mon, 11 Apr 2016 17:31:47 +0000
Message-ID: <1460395905.5119.43.camel@synopsys.com>
References: <57033DBB.6060600@gmail.com>
 <1459932086-6394-1-git-send-email-zengzhaoxiu@163.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459932086-6394-1-git-send-email-zengzhaoxiu@163.com>
Content-Language: en-US
Content-ID: <73E3AD6D2661E84D82658B32CA39C6C3@internal.synopsys.com>
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
Content-Type: text/plain; charset="us-ascii"
To: "zengzhaoxiu@163.com" <zengzhaoxiu@163.com>
Cc: "dalias@libc.org" <dalias@libc.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "brueckner@linux.vnet.ibm.com" <brueckner@linux.vnet.ibm.com>, "linux@lists.openrisc.net" <linux@lists.openrisc.net>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "jonas@southpole.se" <jonas@southpole.se>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, lin

SGkrQUtBLVpoYW94aXUsCgpPbiBXZWQsIDIwMTYtMDQtMDYgYXQgMTY6NDEgKy0wODAwLCB6ZW5n
emhhb3hpdUAxNjMuY29tIHdyb3RlOgo+IEZyb206IFpoYW94aXUgWmVuZyA8emhhb3hpdS56ZW5n
QGdtYWlsLmNvbT4KPiAKPiBVc2UgdGhlIGdlbmVyaWMgdmVyc2lvbgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IFpoYW94aXUgWmVuZyA8emhhb3hpdS56ZW5nQGdtYWlsLmNvbT4KPiAtLS0KPiArQUtBLWFy
Y2gvYXJjL2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQUNnQUtBQW9BQ2d8IDEgKy0KPiArQUtB
LWFyY2gvYXJtL2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQUNnQUtBQW9BQ2d8IDEgKy0KPiAr
QUtBLWFyY2gvYXJtNjQvaW5jbHVkZS9hc20vYml0b3BzLmgrQUtBQW9BQ2dBS0F8IDEgKy0KPiAr
QUtBLWFyY2gvYXZyMzIvaW5jbHVkZS9hc20vYml0b3BzLmgrQUtBQW9BQ2dBS0F8IDEgKy0KPiAr
QUtBLWFyY2gvYzZ4L2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQUNnQUtBQW9BQ2d8IDEgKy0K
PiArQUtBLWFyY2gvY3Jpcy9pbmNsdWRlL2FzbS9iaXRvcHMuaCtBS0FBb0FDZ0FLQUFvQXwgMSAr
LQo+ICtBS0EtYXJjaC9mcnYvaW5jbHVkZS9hc20vYml0b3BzLmgrQUtBQW9BQ2dBS0FBb0FDZ3wg
MSArLQo+ICtBS0EtYXJjaC9oODMwMC9pbmNsdWRlL2FzbS9iaXRvcHMuaCtBS0FBb0FDZ0FLQXwg
MSArLQo+ICtBS0EtYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQXwgMSAr
LQo+ICtBS0EtYXJjaC9tMzJyL2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQUNnQUtBQW9BfCAx
ICstCj4gK0FLQS1hcmNoL202OGsvaW5jbHVkZS9hc20vYml0b3BzLmgrQUtBQW9BQ2dBS0FBb0F8
IDEgKy0KPiArQUtBLWFyY2gvbWV0YWcvaW5jbHVkZS9hc20vYml0b3BzLmgrQUtBQW9BQ2dBS0F8
IDEgKy0KPiArQUtBLWFyY2gvbW4xMDMwMC9pbmNsdWRlL2FzbS9iaXRvcHMuaCtBS0FBb0F8IDEg
Ky0KPiArQUtBLWFyY2gvb3BlbnJpc2MvaW5jbHVkZS9hc20vYml0b3BzLmggfCAxICstCj4gK0FL
QS1hcmNoL3BhcmlzYy9pbmNsdWRlL2FzbS9iaXRvcHMuaCtBS0FBb0FDZ3wgMSArLQo+ICtBS0Et
YXJjaC9zMzkwL2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQUNnQUtBQW9BfCAxICstCj4gK0FL
QS1hcmNoL3NoL2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQUNnQUtBQW9BQ2dBS0F8IDEgKy0K
PiArQUtBLWFyY2gveHRlbnNhL2luY2x1ZGUvYXNtL2JpdG9wcy5oK0FLQUFvQUNnfCAxICstCj4g
K0FLQS0xOCBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCstKQoKQ291bGQgeW91IHBsZWFz
ZSBpbmNsdWRlIGEgY2hhbmdlbG9nIGJlbG93IHlvdXIgY29tbWl0IG1lc3NhZ2U/Ck90aGVyd2lz
ZSBpdCdzIGJhcmVseSBwb3NzaWJsZSB0byB1bmRlcnN0YW5kIHdoYXQgdGhhdCB2MiBpbXByb3Zl
cy9maXhlcy4KCkFsc28gaXQgbWFrZXMgc2Vuc2UgdG8gc2VuZCBhdCBsZWFzdCBjb3ZlciBsZXR0
ZXIgdG8gYWxsIHBlb3BsZSBtZW50aW9uZWQKYXQgbGVhc3QgaW4gb25lIHBhdGNoIG9mIHRoZSBz
ZXJpZXMuIFRoYXQgZ2l2ZXMgYW4gaWRlYSB3aGF0IHRoaXMgc2VyaWVzCmRvZXMgYW5kIGluIHBh
cnRpY3VsYXIgd2h5IHBhdGNoIEknbSBtZW50aW9uZWQgaW4gaXMgcmVxdWlyZWQuCgotQWxleGV5
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXNu
cHMtYXJjIG1haWxpbmcgbGlzdApsaW51eC1zbnBzLWFyY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtc25wcy1hcmM=
