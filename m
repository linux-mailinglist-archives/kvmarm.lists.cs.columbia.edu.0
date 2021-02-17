Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3A31DCF5
	for <lists+kvmarm@lfdr.de>; Wed, 17 Feb 2021 17:11:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A0F1D4B58C;
	Wed, 17 Feb 2021 11:11:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPWWNH2IKIPZ; Wed, 17 Feb 2021 11:11:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 12B0C4B589;
	Wed, 17 Feb 2021 11:11:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6E884B4D2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Feb 2021 11:11:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sEg8J-7HACWQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Feb 2021 11:11:34 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 473FF4B254
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Feb 2021 11:11:34 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEBB91063;
 Wed, 17 Feb 2021 08:11:33 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3BC43F694;
 Wed, 17 Feb 2021 08:11:32 -0800 (PST)
Subject: Re: [PATCH kvmtool 19/21] Remove ioport specific routines
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
 <20201210142908.169597-20-andre.przywara@arm.com>
 <05a0df3a-625f-74de-8014-e78aee9e8427@arm.com>
Message-ID: <389aa087-b079-cafb-b018-eab599e337ed@arm.com>
Date: Wed, 17 Feb 2021 16:11:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <05a0df3a-625f-74de-8014-e78aee9e8427@arm.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Andre,

On 2/17/21 3:49 PM, Alexandru Elisei wrote:
> Hi Andre,
>
> On 12/10/20 2:29 PM, Andre Przywara wrote:
>> Now that all users of the dedicated ioport trap handler interface are
>> gone, we can retire the code associated with it.
>>
>> This removes ioport.c and ioport.h, along with removing prototypes from
>> other header files.
>>
>> This also transfers the responsibility for port I/O trap handling
>> entirely into the new routine in mmio.c.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  Makefile             |   1 -
>>  include/kvm/ioport.h |  20 -----
>>  include/kvm/kvm.h    |   2 -
>>  ioport.c             | 173 -------------------------------------------
>>  mmio.c               |   2 +-
>>  5 files changed, 1 insertion(+), 197 deletions(-)
>>  delete mode 100644 ioport.c
>>
>> diff --git a/Makefile b/Makefile
>> index 35bb1182..94ff5da6 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -56,7 +56,6 @@ OBJS	+= framebuffer.o
>>  OBJS	+= guest_compat.o
>>  OBJS	+= hw/rtc.o
>>  OBJS	+= hw/serial.o
>> -OBJS	+= ioport.o
>>  OBJS	+= irq.o
>>  OBJS	+= kvm-cpu.o
>>  OBJS	+= kvm.o
>> diff --git a/include/kvm/ioport.h b/include/kvm/ioport.h
>> index a61038e2..38636553 100644
>> --- a/include/kvm/ioport.h
>> +++ b/include/kvm/ioport.h
>> @@ -17,28 +17,8 @@
>>  
>>  struct kvm;
> Looks to me like the above forward declaration can be removed; same for all the
> includes except linux/byteorder.h, needed for the lexx_to_cpu/cpu_to_lexx
> functions, and linux/types.h for the uxx typedefs. Otherwise looks good.

Actually, ignore the part about removing the includes, it opens a new can of worms
- byteorder.h doesn't include compiler.h where __always_inline is defined, and
various files where struct kvm_cpu is used don't include kvm-cpu.h (like pci.c,
hw/serial.c, etc). The header removal is not trivial and I think it should be part
of another cleanup patch.

Thanks,

Alex

>
> Thanks,
>
> Alex
>
>>  
>> -struct ioport {
>> -	struct rb_int_node		node;
>> -	struct ioport_operations	*ops;
>> -	void				*priv;
>> -	struct device_header		dev_hdr;
>> -	u32				refcount;
>> -	bool				remove;
>> -};
>> -
>> -struct ioport_operations {
>> -	bool (*io_in)(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size);
>> -	bool (*io_out)(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size);
>> -};
>> -
>>  void ioport__map_irq(u8 *irq);
>>  
>> -int __must_check ioport__register(struct kvm *kvm, u16 port, struct ioport_operations *ops,
>> -				  int count, void *param);
>> -int ioport__unregister(struct kvm *kvm, u16 port);
>> -int ioport__init(struct kvm *kvm);
>> -int ioport__exit(struct kvm *kvm);
>> -
>>  static inline u8 ioport__read8(u8 *data)
>>  {
>>  	return *data;
>> diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
>> index 14f9d58b..e70f8ef6 100644
>> --- a/include/kvm/kvm.h
>> +++ b/include/kvm/kvm.h
>> @@ -119,8 +119,6 @@ void kvm__irq_line(struct kvm *kvm, int irq, int level);
>>  void kvm__irq_trigger(struct kvm *kvm, int irq);
>>  bool kvm__emulate_io(struct kvm_cpu *vcpu, u16 port, void *data, int direction, int size, u32 count);
>>  bool kvm__emulate_mmio(struct kvm_cpu *vcpu, u64 phys_addr, u8 *data, u32 len, u8 is_write);
>> -bool kvm__emulate_pio(struct kvm_cpu *vcpu, u16 port, void *data,
>> -		      int direction, int size, u32 count);
>>  int kvm__destroy_mem(struct kvm *kvm, u64 guest_phys, u64 size, void *userspace_addr);
>>  int kvm__register_mem(struct kvm *kvm, u64 guest_phys, u64 size, void *userspace_addr,
>>  		      enum kvm_mem_type type);
>> diff --git a/ioport.c b/ioport.c
>> deleted file mode 100644
>> index 204d8103..00000000
>> --- a/ioport.c
>> +++ /dev/null
>> @@ -1,173 +0,0 @@
>> -#include "kvm/ioport.h"
>> -
>> -#include "kvm/kvm.h"
>> -#include "kvm/util.h"
>> -#include "kvm/rbtree-interval.h"
>> -#include "kvm/mutex.h"
>> -
>> -#include <linux/kvm.h>	/* for KVM_EXIT_* */
>> -#include <linux/types.h>
>> -
>> -#include <stdbool.h>
>> -#include <limits.h>
>> -#include <stdlib.h>
>> -#include <stdio.h>
>> -
>> -#define ioport_node(n) rb_entry(n, struct ioport, node)
>> -
>> -static DEFINE_MUTEX(ioport_lock);
>> -
>> -static struct rb_root		ioport_tree = RB_ROOT;
>> -
>> -static struct ioport *ioport_search(struct rb_root *root, u64 addr)
>> -{
>> -	struct rb_int_node *node;
>> -
>> -	node = rb_int_search_single(root, addr);
>> -	if (node == NULL)
>> -		return NULL;
>> -
>> -	return ioport_node(node);
>> -}
>> -
>> -static int ioport_insert(struct rb_root *root, struct ioport *data)
>> -{
>> -	return rb_int_insert(root, &data->node);
>> -}
>> -
>> -static void ioport_remove(struct rb_root *root, struct ioport *data)
>> -{
>> -	rb_int_erase(root, &data->node);
>> -}
>> -
>> -static struct ioport *ioport_get(struct rb_root *root, u64 addr)
>> -{
>> -	struct ioport *ioport;
>> -
>> -	mutex_lock(&ioport_lock);
>> -	ioport = ioport_search(root, addr);
>> -	if (ioport)
>> -		ioport->refcount++;
>> -	mutex_unlock(&ioport_lock);
>> -
>> -	return ioport;
>> -}
>> -
>> -/* Called with ioport_lock held. */
>> -static void ioport_unregister(struct rb_root *root, struct ioport *data)
>> -{
>> -	ioport_remove(root, data);
>> -	free(data);
>> -}
>> -
>> -static void ioport_put(struct rb_root *root, struct ioport *data)
>> -{
>> -	mutex_lock(&ioport_lock);
>> -	data->refcount--;
>> -	if (data->remove && data->refcount == 0)
>> -		ioport_unregister(root, data);
>> -	mutex_unlock(&ioport_lock);
>> -}
>> -
>> -int ioport__register(struct kvm *kvm, u16 port, struct ioport_operations *ops, int count, void *param)
>> -{
>> -	struct ioport *entry;
>> -	int r;
>> -
>> -	entry = malloc(sizeof(*entry));
>> -	if (entry == NULL)
>> -		return -ENOMEM;
>> -
>> -	*entry = (struct ioport) {
>> -		.node		= RB_INT_INIT(port, port + count),
>> -		.ops		= ops,
>> -		.priv		= param,
>> -		/*
>> -		 * Start from 0 because ioport__unregister() doesn't decrement
>> -		 * the reference count.
>> -		 */
>> -		.refcount	= 0,
>> -		.remove		= false,
>> -	};
>> -
>> -	mutex_lock(&ioport_lock);
>> -	r = ioport_insert(&ioport_tree, entry);
>> -	if (r < 0)
>> -		goto out_free;
>> -	mutex_unlock(&ioport_lock);
>> -
>> -	return port;
>> -
>> -out_free:
>> -	free(entry);
>> -	mutex_unlock(&ioport_lock);
>> -	return r;
>> -}
>> -
>> -int ioport__unregister(struct kvm *kvm, u16 port)
>> -{
>> -	struct ioport *entry;
>> -
>> -	mutex_lock(&ioport_lock);
>> -	entry = ioport_search(&ioport_tree, port);
>> -	if (!entry) {
>> -		mutex_unlock(&ioport_lock);
>> -		return -ENOENT;
>> -	}
>> -	/* The same reasoning from kvm__deregister_mmio() applies. */
>> -	if (entry->refcount == 0)
>> -		ioport_unregister(&ioport_tree, entry);
>> -	else
>> -		entry->remove = true;
>> -	mutex_unlock(&ioport_lock);
>> -
>> -	return 0;
>> -}
>> -
>> -static const char *to_direction(int direction)
>> -{
>> -	if (direction == KVM_EXIT_IO_IN)
>> -		return "IN";
>> -	else
>> -		return "OUT";
>> -}
>> -
>> -static void ioport_error(u16 port, void *data, int direction, int size, u32 count)
>> -{
>> -	fprintf(stderr, "IO error: %s port=%x, size=%d, count=%u\n", to_direction(direction), port, size, count);
>> -}
>> -
>> -bool kvm__emulate_io(struct kvm_cpu *vcpu, u16 port, void *data, int direction, int size, u32 count)
>> -{
>> -	struct ioport_operations *ops;
>> -	bool ret = false;
>> -	struct ioport *entry;
>> -	void *ptr = data;
>> -	struct kvm *kvm = vcpu->kvm;
>> -
>> -	entry = ioport_get(&ioport_tree, port);
>> -	if (!entry)
>> -		return kvm__emulate_pio(vcpu, port, data, direction,
>> -					size, count);
>> -
>> -	ops	= entry->ops;
>> -
>> -	while (count--) {
>> -		if (direction == KVM_EXIT_IO_IN && ops->io_in)
>> -				ret = ops->io_in(entry, vcpu, port, ptr, size);
>> -		else if (direction == KVM_EXIT_IO_OUT && ops->io_out)
>> -				ret = ops->io_out(entry, vcpu, port, ptr, size);
>> -
>> -		ptr += size;
>> -	}
>> -
>> -	ioport_put(&ioport_tree, entry);
>> -
>> -	if (ret)
>> -		return true;
>> -
>> -	if (kvm->cfg.ioport_debug)
>> -		ioport_error(port, data, direction, size, count);
>> -
>> -	return !kvm->cfg.ioport_debug;
>> -}
>> diff --git a/mmio.c b/mmio.c
>> index 4cce1901..5249af39 100644
>> --- a/mmio.c
>> +++ b/mmio.c
>> @@ -206,7 +206,7 @@ out:
>>  	return true;
>>  }
>>  
>> -bool kvm__emulate_pio(struct kvm_cpu *vcpu, u16 port, void *data,
>> +bool kvm__emulate_io(struct kvm_cpu *vcpu, u16 port, void *data,
>>  		     int direction, int size, u32 count)
>>  {
>>  	struct mmio_mapping *mmio;
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
