Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 731F04DC2A6
	for <lists+kvmarm@lfdr.de>; Thu, 17 Mar 2022 10:28:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFCD94A36B;
	Thu, 17 Mar 2022 05:28:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xKMyxDaAU2Zw; Thu, 17 Mar 2022 05:28:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C11A849F1E;
	Thu, 17 Mar 2022 05:28:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EFD3649EBF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 14:02:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWicsWexipGq for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Mar 2022 14:02:30 -0400 (EDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1119649EBE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 14:02:29 -0400 (EDT)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-2dbd8777564so33223647b3.0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NgMz9yyMA/RltwwVeNoTiOQDwGQeI9oxQlJCUs10hwA=;
 b=WhtcS8gF7Giu/FeoCj4XBULQ61pwBhaUUyc2L3p2o5HO9a3bMOLXpabPqKxuX4KoVp
 WHWz4/A+7wcnmeh+NgzhuuL2M8pdQS0voPvl3hgndNwDx7XKzHbJMHj1jlT+mzNwcTTy
 Fnp+q8Aabp58UF83tDGxjcGfNH5s6vR6A0R+f2BBSzF3oB1YIzZYdlSSe3M/rtJJq2kz
 Gi/GyBCYhuFfHQZaNJxsmCqn2bES2ctZf9jqdnW1KjHn1iO2FQZ1RwzBl+Kjb5LXGtoq
 msgJ8YAHXN72PwH1sQnzr3ZXb0Ww9YwlZ7Z66smTE4IyV54LkwBa5nXQCBZ9dze/TTg1
 W7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NgMz9yyMA/RltwwVeNoTiOQDwGQeI9oxQlJCUs10hwA=;
 b=21kAzFIX2SyYRkIrEut7y4nkqbd2qJdxd1HRhWXdpNSbZw3XDflvNdcMdnOnbSIFlK
 QLtqfqhmrZo4ElQ/LWWhiybL9ZSII80DKMJ52fYxZqJp89LAHq80bX+59vR58GSX1blV
 VfwNKRH3toVGRUmNNCIezfapyIeKGE4fSRnE8u5QS+pK2G2Jto34hbrLzNg/7EcFU9i7
 DEsifG75yOO4Do8TXhcmlnzm0miZJtvx/cflcCQVBfT42fsuFIGCWWxasXfxaczVhlzw
 UF6VdPN1lcliu6OdG6Z6NqCSVAW+uYJ6pVSKY8VoHZDVX9c8R1cvRSGIE4djfokQp4pF
 ubbw==
X-Gm-Message-State: AOAM5337amWX1Izs35UOJFdIq9YWceiChU/i80MqUfRFZpw0Ts6PM4Zg
 Sj1G95mnbIHJFgJ5RZYDEeiokb3tmhrFzRXb6sUKKw==
X-Google-Smtp-Source: ABdhPJwqXRm86uLyZg49KeDJiwh19pULSJLvdH3Wn1krZXS9/XDLnVmxhDpjjyAprJLPfDIGphUio37bDEAWqnND3Ec=
X-Received: by 2002:a81:6c6:0:b0:2dc:616b:468b with SMTP id
 189-20020a8106c6000000b002dc616b468bmr1433129ywg.472.1647453749092; Wed, 16
 Mar 2022 11:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220311060207.2438667-1-ricarkol@google.com>
 <20220311060207.2438667-2-ricarkol@google.com>
In-Reply-To: <20220311060207.2438667-2-ricarkol@google.com>
From: Ben Gardon <bgardon@google.com>
Date: Wed, 16 Mar 2022 12:02:18 -0600
Message-ID: <CANgfPd81R3oiyYeC6PucqFdUEWYzf9ooqCb_gJWf2URxnPabwQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] KVM: selftests: Add a userfaultfd library
To: Ricardo Koller <ricarkol@google.com>
X-Mailman-Approved-At: Thu, 17 Mar 2022 05:28:50 -0400
Cc: kvm <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>,
 kvmarm@lists.cs.columbia.edu
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

On Fri, Mar 11, 2022 at 12:02 AM Ricardo Koller <ricarkol@google.com> wrote:
>
> Move the generic userfaultfd code out of demand_paging_test.c into a
> common library, userfaultfd_util. This library consists of a setup and a
> stop function. The setup function starts a thread for handling page
> faults using the handler callback function. This setup returns a
> uffd_desc object which is then used in the stop function (to wait and
> destroy the threads).
>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   2 +-
>  .../selftests/kvm/demand_paging_test.c        | 227 +++---------------
>  .../selftests/kvm/include/userfaultfd_util.h  |  46 ++++
>  .../selftests/kvm/lib/userfaultfd_util.c      | 196 +++++++++++++++
>  4 files changed, 272 insertions(+), 199 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/userfaultfd_util.h
>  create mode 100644 tools/testing/selftests/kvm/lib/userfaultfd_util.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 0e4926bc9a58..bc5f89b3700e 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -37,7 +37,7 @@ ifeq ($(ARCH),riscv)
>         UNAME_M := riscv
>  endif
>
> -LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
> +LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c lib/userfaultfd_util.c
>  LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
>  LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
>  LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 6a719d065599..b3d457cecd68 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -22,23 +22,13 @@
>  #include "test_util.h"
>  #include "perf_test_util.h"
>  #include "guest_modes.h"
> +#include "userfaultfd_util.h"
>
>  #ifdef __NR_userfaultfd
>
> -#ifdef PRINT_PER_PAGE_UPDATES
> -#define PER_PAGE_DEBUG(...) printf(__VA_ARGS__)
> -#else
> -#define PER_PAGE_DEBUG(...) _no_printf(__VA_ARGS__)
> -#endif
> -
> -#ifdef PRINT_PER_VCPU_UPDATES
> -#define PER_VCPU_DEBUG(...) printf(__VA_ARGS__)
> -#else
> -#define PER_VCPU_DEBUG(...) _no_printf(__VA_ARGS__)
> -#endif
> -
>  static int nr_vcpus = 1;
>  static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
> +
>  static size_t demand_paging_size;
>  static char *guest_data_prototype;
>
> @@ -69,9 +59,11 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
>                        ts_diff.tv_sec, ts_diff.tv_nsec);
>  }
>
> -static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
> +static int handle_uffd_page_request(int uffd_mode, int uffd,
> +               struct uffd_msg *msg)
>  {
>         pid_t tid = syscall(__NR_gettid);
> +       uint64_t addr = msg->arg.pagefault.address;
>         struct timespec start;
>         struct timespec ts_diff;
>         int r;
> @@ -118,175 +110,32 @@ static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
>         return 0;
>  }
>
> -bool quit_uffd_thread;
> -
> -struct uffd_handler_args {
> +struct test_params {
>         int uffd_mode;
> -       int uffd;
> -       int pipefd;
> -       useconds_t delay;
> +       useconds_t uffd_delay;
> +       enum vm_mem_backing_src_type src_type;
> +       bool partition_vcpu_memory_access;
>  };
>
> -static void *uffd_handler_thread_fn(void *arg)
> +static void prefault_mem(void *alias, uint64_t len)
>  {
> -       struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
> -       int uffd = uffd_args->uffd;
> -       int pipefd = uffd_args->pipefd;
> -       useconds_t delay = uffd_args->delay;
> -       int64_t pages = 0;
> -       struct timespec start;
> -       struct timespec ts_diff;
> -
> -       clock_gettime(CLOCK_MONOTONIC, &start);
> -       while (!quit_uffd_thread) {
> -               struct uffd_msg msg;
> -               struct pollfd pollfd[2];
> -               char tmp_chr;
> -               int r;
> -               uint64_t addr;
> -
> -               pollfd[0].fd = uffd;
> -               pollfd[0].events = POLLIN;
> -               pollfd[1].fd = pipefd;
> -               pollfd[1].events = POLLIN;
> -
> -               r = poll(pollfd, 2, -1);
> -               switch (r) {
> -               case -1:
> -                       pr_info("poll err");
> -                       continue;
> -               case 0:
> -                       continue;
> -               case 1:
> -                       break;
> -               default:
> -                       pr_info("Polling uffd returned %d", r);
> -                       return NULL;
> -               }
> -
> -               if (pollfd[0].revents & POLLERR) {
> -                       pr_info("uffd revents has POLLERR");
> -                       return NULL;
> -               }
> -
> -               if (pollfd[1].revents & POLLIN) {
> -                       r = read(pollfd[1].fd, &tmp_chr, 1);
> -                       TEST_ASSERT(r == 1,
> -                                   "Error reading pipefd in UFFD thread\n");
> -                       return NULL;
> -               }
> -
> -               if (!(pollfd[0].revents & POLLIN))
> -                       continue;
> -
> -               r = read(uffd, &msg, sizeof(msg));
> -               if (r == -1) {
> -                       if (errno == EAGAIN)
> -                               continue;
> -                       pr_info("Read of uffd got errno %d\n", errno);
> -                       return NULL;
> -               }
> -
> -               if (r != sizeof(msg)) {
> -                       pr_info("Read on uffd returned unexpected size: %d bytes", r);
> -                       return NULL;
> -               }
> -
> -               if (!(msg.event & UFFD_EVENT_PAGEFAULT))
> -                       continue;
> +       size_t p;
>
> -               if (delay)
> -                       usleep(delay);
> -               addr =  msg.arg.pagefault.address;
> -               r = handle_uffd_page_request(uffd_args->uffd_mode, uffd, addr);
> -               if (r < 0)
> -                       return NULL;
> -               pages++;
> +       TEST_ASSERT(alias != NULL, "Alias required for minor faults");
> +       for (p = 0; p < (len / demand_paging_size); ++p) {
> +               memcpy(alias + (p * demand_paging_size),
> +                      guest_data_prototype, demand_paging_size);
>         }
> -
> -       ts_diff = timespec_elapsed(start);
> -       PER_VCPU_DEBUG("userfaulted %ld pages over %ld.%.9lds. (%f/sec)\n",
> -                      pages, ts_diff.tv_sec, ts_diff.tv_nsec,
> -                      pages / ((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
> -
> -       return NULL;
>  }
>
> -static void setup_demand_paging(struct kvm_vm *vm,
> -                               pthread_t *uffd_handler_thread, int pipefd,
> -                               int uffd_mode, useconds_t uffd_delay,
> -                               struct uffd_handler_args *uffd_args,
> -                               void *hva, void *alias, uint64_t len)
> -{
> -       bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
> -       int uffd;
> -       struct uffdio_api uffdio_api;
> -       struct uffdio_register uffdio_register;
> -       uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
> -
> -       PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
> -                      is_minor ? "MINOR" : "MISSING",
> -                      is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
> -
> -       /* In order to get minor faults, prefault via the alias. */
> -       if (is_minor) {
> -               size_t p;
> -
> -               expected_ioctls = ((uint64_t) 1) << _UFFDIO_CONTINUE;
> -
> -               TEST_ASSERT(alias != NULL, "Alias required for minor faults");
> -               for (p = 0; p < (len / demand_paging_size); ++p) {
> -                       memcpy(alias + (p * demand_paging_size),
> -                              guest_data_prototype, demand_paging_size);
> -               }
> -       }
> -
> -       uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> -       TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
> -
> -       uffdio_api.api = UFFD_API;
> -       uffdio_api.features = 0;
> -       TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffdio_api) != -1,
> -                   "ioctl UFFDIO_API failed: %" PRIu64,
> -                   (uint64_t)uffdio_api.api);
> -
> -       uffdio_register.range.start = (uint64_t)hva;
> -       uffdio_register.range.len = len;
> -       uffdio_register.mode = uffd_mode;
> -       TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
> -                   "ioctl UFFDIO_REGISTER failed");
> -       TEST_ASSERT((uffdio_register.ioctls & expected_ioctls) ==
> -                   expected_ioctls, "missing userfaultfd ioctls");
> -
> -       uffd_args->uffd_mode = uffd_mode;
> -       uffd_args->uffd = uffd;
> -       uffd_args->pipefd = pipefd;
> -       uffd_args->delay = uffd_delay;
> -       pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
> -                      uffd_args);
> -
> -       PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
> -                      hva, hva + len);
> -}
> -
> -struct test_params {
> -       int uffd_mode;
> -       useconds_t uffd_delay;
> -       enum vm_mem_backing_src_type src_type;
> -       bool partition_vcpu_memory_access;
> -};
> -
>  static void run_test(enum vm_guest_mode mode, void *arg)
>  {
>         struct test_params *p = arg;
> -       pthread_t *uffd_handler_threads = NULL;
> -       struct uffd_handler_args *uffd_args = NULL;
> +       struct uffd_desc **uffd_descs = NULL;
>         struct timespec start;
>         struct timespec ts_diff;
> -       int *pipefds = NULL;
>         struct kvm_vm *vm;
>         int vcpu_id;
> -       int r;
>
>         vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
>                                  p->src_type, p->partition_vcpu_memory_access);
> @@ -299,15 +148,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         memset(guest_data_prototype, 0xAB, demand_paging_size);
>
>         if (p->uffd_mode) {
> -               uffd_handler_threads =
> -                       malloc(nr_vcpus * sizeof(*uffd_handler_threads));
> -               TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
> -
> -               uffd_args = malloc(nr_vcpus * sizeof(*uffd_args));
> -               TEST_ASSERT(uffd_args, "Memory allocation failed");
> -
> -               pipefds = malloc(sizeof(int) * nr_vcpus * 2);
> -               TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
> +               uffd_descs = malloc(nr_vcpus * sizeof(struct uffd_desc *));
> +               TEST_ASSERT(uffd_descs, "Memory allocation failed");
>
>                 for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>                         struct perf_test_vcpu_args *vcpu_args;
> @@ -320,19 +162,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                         vcpu_hva = addr_gpa2hva(vm, vcpu_args->gpa);
>                         vcpu_alias = addr_gpa2alias(vm, vcpu_args->gpa);
>
> +                       prefault_mem(vcpu_alias,
> +                               vcpu_args->pages * perf_test_args.guest_page_size);
> +
>                         /*
>                          * Set up user fault fd to handle demand paging
>                          * requests.
>                          */
> -                       r = pipe2(&pipefds[vcpu_id * 2],
> -                                 O_CLOEXEC | O_NONBLOCK);
> -                       TEST_ASSERT(!r, "Failed to set up pipefd");
> -
> -                       setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
> -                                           pipefds[vcpu_id * 2], p->uffd_mode,
> -                                           p->uffd_delay, &uffd_args[vcpu_id],
> -                                           vcpu_hva, vcpu_alias,
> -                                           vcpu_args->pages * perf_test_args.guest_page_size);
> +                       uffd_descs[vcpu_id] = uffd_setup_demand_paging(
> +                               p->uffd_mode, p->uffd_delay, vcpu_hva,
> +                               vcpu_args->pages * perf_test_args.guest_page_size,
> +                               &handle_uffd_page_request);
>                 }
>         }
>
> @@ -347,15 +187,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         pr_info("All vCPU threads joined\n");
>
>         if (p->uffd_mode) {
> -               char c;
> -
>                 /* Tell the user fault fd handler threads to quit */
> -               for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
> -                       r = write(pipefds[vcpu_id * 2 + 1], &c, 1);
> -                       TEST_ASSERT(r == 1, "Unable to write to pipefd");
> -
> -                       pthread_join(uffd_handler_threads[vcpu_id], NULL);
> -               }
> +               for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++)
> +                       uffd_stop_demand_paging(uffd_descs[vcpu_id]);
>         }
>
>         pr_info("Total guest execution time: %ld.%.9lds\n",
> @@ -367,11 +201,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         perf_test_destroy_vm(vm);
>
>         free(guest_data_prototype);
> -       if (p->uffd_mode) {
> -               free(uffd_handler_threads);
> -               free(uffd_args);
> -               free(pipefds);
> -       }
> +       if (p->uffd_mode)
> +               free(uffd_descs);
>  }
>
>  static void help(char *name)
> diff --git a/tools/testing/selftests/kvm/include/userfaultfd_util.h b/tools/testing/selftests/kvm/include/userfaultfd_util.h
> new file mode 100644
> index 000000000000..7b294ce8147c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/userfaultfd_util.h
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KVM userfaultfd util
> + * Adapted from demand_paging_test.c
> + *
> + * Copyright (C) 2018, Red Hat, Inc.
> + * Copyright (C) 2019, Google, Inc.
> + * Copyright (C) 2022, Google, Inc.
> + */
> +
> +#define _GNU_SOURCE /* for pipe2 */
> +
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <poll.h>
> +#include <pthread.h>
> +#include <linux/userfaultfd.h>
> +#include <sys/syscall.h>
> +
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "perf_test_util.h"
> +
> +typedef int (*uffd_handler_t)(int uffd_mode, int uffd, struct uffd_msg *msg);
> +
> +struct uffd_desc;

Do we gain anything from making this opaque? Given the 100+ patch
series Sean just sent out to expose the KVM util library functions,
I'd be inclined to just define the struct in the header file.

Otherwise, I'm really happy to see all this code factored out into its
own little library.

> +
> +struct uffd_desc *uffd_setup_demand_paging(int uffd_mode,
> +               useconds_t uffd_delay, void *hva, uint64_t len,
> +               uffd_handler_t handler);
> +
> +void uffd_stop_demand_paging(struct uffd_desc *uffd);
> +
> +#ifdef PRINT_PER_PAGE_UPDATES
> +#define PER_PAGE_DEBUG(...) printf(__VA_ARGS__)
> +#else
> +#define PER_PAGE_DEBUG(...) _no_printf(__VA_ARGS__)
> +#endif
> +
> +#ifdef PRINT_PER_VCPU_UPDATES
> +#define PER_VCPU_DEBUG(...) printf(__VA_ARGS__)
> +#else
> +#define PER_VCPU_DEBUG(...) _no_printf(__VA_ARGS__)
> +#endif
> diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> new file mode 100644
> index 000000000000..5e0878878a69
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KVM userfaultfd util
> + * Adapted from demand_paging_test.c
> + *
> + * Copyright (C) 2018, Red Hat, Inc.
> + * Copyright (C) 2019, Google, Inc.
> + * Copyright (C) 2022, Google, Inc.
> + */
> +
> +#define _GNU_SOURCE /* for pipe2 */
> +
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <poll.h>
> +#include <pthread.h>
> +#include <linux/userfaultfd.h>
> +#include <sys/syscall.h>
> +
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "perf_test_util.h"
> +#include "userfaultfd_util.h"
> +
> +#ifdef __NR_userfaultfd
> +
> +struct uffd_desc {
> +       int uffd_mode;
> +       int uffd;
> +       int pipefds[2];
> +       useconds_t delay;
> +       uffd_handler_t handler;
> +       pthread_t thread;
> +};
> +
> +static void *uffd_handler_thread_fn(void *arg)
> +{
> +       struct uffd_desc *uffd_desc = (struct uffd_desc *)arg;
> +       int uffd = uffd_desc->uffd;
> +       int pipefd = uffd_desc->pipefds[0];
> +       useconds_t delay = uffd_desc->delay;
> +       int64_t pages = 0;
> +       struct timespec start;
> +       struct timespec ts_diff;
> +
> +       clock_gettime(CLOCK_MONOTONIC, &start);
> +       while (1) {
> +               struct uffd_msg msg;
> +               struct pollfd pollfd[2];
> +               char tmp_chr;
> +               int r;
> +
> +               pollfd[0].fd = uffd;
> +               pollfd[0].events = POLLIN;
> +               pollfd[1].fd = pipefd;
> +               pollfd[1].events = POLLIN;
> +
> +               r = poll(pollfd, 2, -1);
> +               switch (r) {
> +               case -1:
> +                       pr_info("poll err");
> +                       continue;
> +               case 0:
> +                       continue;
> +               case 1:
> +                       break;
> +               default:
> +                       pr_info("Polling uffd returned %d", r);
> +                       return NULL;
> +               }
> +
> +               if (pollfd[0].revents & POLLERR) {
> +                       pr_info("uffd revents has POLLERR");
> +                       return NULL;
> +               }
> +
> +               if (pollfd[1].revents & POLLIN) {
> +                       r = read(pollfd[1].fd, &tmp_chr, 1);
> +                       TEST_ASSERT(r == 1,
> +                                   "Error reading pipefd in UFFD thread\n");
> +                       return NULL;
> +               }
> +
> +               if (!(pollfd[0].revents & POLLIN))
> +                       continue;
> +
> +               r = read(uffd, &msg, sizeof(msg));
> +               if (r == -1) {
> +                       if (errno == EAGAIN)
> +                               continue;
> +                       pr_info("Read of uffd got errno %d\n", errno);
> +                       return NULL;
> +               }
> +
> +               if (r != sizeof(msg)) {
> +                       pr_info("Read on uffd returned unexpected size: %d bytes", r);
> +                       return NULL;
> +               }
> +
> +               if (!(msg.event & UFFD_EVENT_PAGEFAULT))
> +                       continue;
> +
> +               if (delay)
> +                       usleep(delay);
> +               r = uffd_desc->handler(uffd_desc->uffd_mode, uffd, &msg);
> +               if (r < 0)
> +                       return NULL;
> +               pages++;
> +       }
> +
> +       ts_diff = timespec_elapsed(start);
> +       PER_VCPU_DEBUG("userfaulted %ld pages over %ld.%.9lds. (%f/sec)\n",
> +                      pages, ts_diff.tv_sec, ts_diff.tv_nsec,
> +                      pages / ((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
> +
> +       return NULL;
> +}
> +
> +struct uffd_desc *uffd_setup_demand_paging(int uffd_mode,
> +               useconds_t uffd_delay, void *hva, uint64_t len,
> +               uffd_handler_t handler)
> +{
> +       struct uffd_desc *uffd_desc;
> +       bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
> +       int uffd;
> +       struct uffdio_api uffdio_api;
> +       struct uffdio_register uffdio_register;
> +       uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
> +       int ret;
> +
> +       PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
> +                      is_minor ? "MINOR" : "MISSING",
> +                      is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
> +
> +       uffd_desc = malloc(sizeof(struct uffd_desc));
> +       TEST_ASSERT(uffd_desc, "malloc failed");
> +
> +       /* In order to get minor faults, prefault via the alias. */
> +       if (is_minor)
> +               expected_ioctls = ((uint64_t) 1) << _UFFDIO_CONTINUE;
> +
> +       uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> +       TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
> +
> +       uffdio_api.api = UFFD_API;
> +       uffdio_api.features = 0;
> +       TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffdio_api) != -1,
> +                   "ioctl UFFDIO_API failed: %" PRIu64,
> +                   (uint64_t)uffdio_api.api);
> +
> +       uffdio_register.range.start = (uint64_t)hva;
> +       uffdio_register.range.len = len;
> +       uffdio_register.mode = uffd_mode;
> +       TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
> +                   "ioctl UFFDIO_REGISTER failed");
> +       TEST_ASSERT((uffdio_register.ioctls & expected_ioctls) ==
> +                       expected_ioctls, "missing userfaultfd ioctls");
> +
> +       ret = pipe2(uffd_desc->pipefds, O_CLOEXEC | O_NONBLOCK);
> +       TEST_ASSERT(!ret, "Failed to set up pipefd");
> +
> +       uffd_desc->uffd_mode = uffd_mode;
> +       uffd_desc->uffd = uffd;
> +       uffd_desc->delay = uffd_delay;
> +       uffd_desc->handler = handler;
> +       pthread_create(&uffd_desc->thread, NULL, uffd_handler_thread_fn,
> +                      uffd_desc);
> +
> +       PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
> +                      hva, hva + len);
> +
> +       return uffd_desc;
> +}
> +
> +void uffd_stop_demand_paging(struct uffd_desc *uffd)
> +{
> +       char c = 0;
> +       int ret;
> +
> +       ret = write(uffd->pipefds[1], &c, 1);
> +       TEST_ASSERT(ret == 1, "Unable to write to pipefd");
> +
> +       ret = pthread_join(uffd->thread, NULL);
> +       TEST_ASSERT(ret == 0, "Pthread_join failed.");
> +
> +       close(uffd->uffd);
> +
> +       close(uffd->pipefds[1]);
> +       close(uffd->pipefds[0]);
> +
> +       free(uffd);
> +}
> +
> +#endif /* __NR_userfaultfd */
> --
> 2.35.1.723.g4982287a31-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
